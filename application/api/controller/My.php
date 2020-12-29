<?php


namespace app\api\controller;


use app\api\validate\User;
use think\Db;
use think\Session;

class My extends Base
{

//获取用户信息
    public function getinfo()
    {
        $res = db('sc_user')->where('id', $this->userInfo['id'])->field('id,nick_name,phone,address,sex,profile_picture')->find();
        $this->ajaxReturn(['error_code' => 0, 'data' => ['userinfo' => $res]]);
    }

//头像上传接口
    public function headerImgUp()
    {
        $files = $this->request->file('headimg');
        $host = 'http://' . $_SERVER['SERVER_NAME'] . '/upload/userhead/';
        $info = $files->validate(['size' => 50000, 'ext' => 'jpg,png,gif'])->move('../public/upload/userhead');
        if ($info) {
            $url = str_replace('\\', '/', $host . $info->getSaveName());
            $this->ajaxReturn(['error_code' => 0, 'data' => ['imgurl' => $url]]);
//            $this->ajaxReturn($url);
        } else {
            $this->ajaxReturn(['error_code' => 1, 'msg' => $files->getError()]);
        }

    }

    public function index()
    {
        $resdata = db('sc_user')->where('id', $this->userInfo['id'])->field('id,nick_name,money,points,profile_picture')->find();

        $couponnum = db('sc_user_coupon')->where('delete_time', 0)->where('user_id', $this->userInfo['id'])->count();
        $resdata['c_num'] = $couponnum;

        $this->ajaxReturn(['error_code' => 0, 'data' => ['user' => $resdata]]);

    }

    //用户信息编辑
    public function edit()
    {
        $nick_name = input('post.nick_name', '', 'trim');
        $sex = input('post.sex', '', 'intval');
        $head_img = input('post.head_img', '', 'trim');
        $phone = input('post.phone', '', 'trim');
        $address = input('post.address', '', 'trim');
//        var_dump($nick_name);
//        die();
        $vauser = validate('user');
        if ($vauser->scene('edit')->check(['nick_name' => $nick_name]) && ($sex == 1 || $sex == 2 || $sex == 0)) {
            db('sc_user')->where('id', $this->userInfo['id'])
                ->update(['nick_name' => $nick_name, 'sex' => $sex, 'profile_picture' => $head_img, 'phone' => $phone, 'address' => $address]);
            $this->ajaxReturn(['error_code' => 0, 'msg' => "编辑成功"]);

        } else {
            $this->ajaxReturn(['error_code' => 1, 'msg' => '编辑错误']);
        }
    }

    //会员储值界面数据
    public function rechargeMsg()
    {
        if ($this->userInfo['vip_validity_time'] > time()) {
            $vip_level = '会员用户  到期时间:' . date('Y-m-d H:i', $this->userInfo['vip_validity_time']);
        } else {
            $vip_level = '普通用户';
        }
        $user = [
            'user_name' => $this->userInfo['name'],
            'vip_level' => $vip_level,
            'money' => $this->userInfo['money']
        ];
        $resRecharge = db('sc_recharge_config')->field('id,get_money,recharge_money')->order('created_time')->limit(3)->select();
        $resVip = db('sc_vip_config')->field('id,days,price')->order('created_time')->limit(3)->select();
        $rData['user'] = $user;
        $rData['res_recharge'] = $resRecharge;
        $rData['res_vip'] = $resVip;
        $this->ajaxReturn(['error_code' => 0, 'data' => $rData]);

    }

    //后续要加入支付宝 或者微信支付接口 vip只能由现金支付
    public function buyVipOrMoney()
    {
        $vid = input('post.vid', 0, 'intval');//vip配置id
        $rid = input('post.rid', 0, 'intval');//充值配置id

        if ($vid == 0 && $rid == 0) {
            $this->ajaxReturn(['error_code' => 1, 'msg' => '参数错误']);
        }


        $vres = db('sc_vip_config')->where('id', $vid)->find();
        $rres = db('sc_recharge_config')->where('id', $rid)->find();

        if (empty($vres) || empty($rres)) {
            $this->ajaxReturn(['error_code' => 1, 'msg' => '参数错误']);
        }

        if ($this->userInfo['vip_validity_time'] > time()) {
            db('sc_user')->where('id', $this->userInfo['id'])->setInc('vip_validity_time', $vres['days'] * 84600);
        } else {
            db('sc_user')->where('id', $this->userInfo['id'])->update(['vip_validity_time' => intval(time()) + ($vres['days'] * 84600)]);

        }
        db('sc_user')->where('id', $this->userInfo['id'])->setInc('money', $rres['get_money']);
        $msg = '花费' . $vres['price'] . '购买' . $vres['days'] . '天会员成功  ' . '花费' . $rres['recharge_money'] . '元 充入平台得到' . $rres['get_money'];
        $this->ajaxReturn(['error_code' => 0, 'msg' => $msg]);
    }

    //我的订单接口
    public function myorder()
    {

        $pagesize = input('get.pagesize', 10, 'intval');
        $page = input('get.page', 1, 'intval');
        $offset = ($page - 1) * $pagesize;
        $type = input('get.type', '-1', 'intval');// -1 全部  0 待付款 1 配送中 2 待收货 3 待评价

        if (in_array($type, [-1, 0, 1, 2, 3])) {
            $query = db('sc_order')
                ->alias('o')
                ->leftJoin('sc_product p', 'o.pro_id=p.id')
                ->where('o.user_id', $this->userInfo['id'])
                ->where('o.delete_time', 0)
                ->limit($offset, $pagesize)
                ->field('o.pro_id,o.pay_money,o.status,o.num,p.size,p.price,p.imgs,p.describe,p.title');
            $orders = null;
            switch ($type) {
                case -1:
                    {
                        $orders = $query->select();
                        break;
                    };
                case 0:
                    {
                        $orders = $query->where('o.status', 0)->select();
                        break;
                    };
                case 1:
                    {
                        $orders = $query->where('o.status', 1)->select();
                        break;
                    };
                case 2:
                    {
                        $orders = $query->where('o.status', 2)->select();
                        break;
                    };
                case 3:
                    {
                        $orders = $query->where('o.status', 3)->select();
                        break;
                    };
            }
            foreach ($orders as &$item) {
                $item['sc_name'] = '小肖的衣服店';
                $item['describe'] = strip_tags($item['describe']);
                $item['describe'] = substr($item['describe'], 0, 40);
                //衣服尺码 0 S, 1 N, 2 L,3 XL,4 XXL
                if ($item['size'] == 0) {
                    $item['size'] = 'S';
                }

                if ($item['size'] == 1) {
                    $item['size'] = 'N';
                }
                if ($item['size'] == 2) {
                    $item['size'] = 'L';
                }
                if ($item['size'] == 3) {
                    $item['size'] = 'XL';
                }
                if ($item['size'] == 4) {
                    $item['size'] = 'XXL';
                }

            }


            $this->ajaxReturn(['error_code' => 0, 'data' => ['order_list' => $orders]]);


        } else {
            $this->ajaxReturn(['error_code' => 1, 'msg' => '参数错误']);
        }


    }

//收藏商品跟取消收藏
    public function collection()
    {
        $pid = input('post.pid', 0, 'intval');
        if (!$pid) {
            $this->ajaxReturn(['error_code' => 1, 'msg' => '参数错误']);
        }
        $res = db('sc_collect')->where('user_id', $this->userInfo['id'])->where('pro_id', $pid)->where('delete_time', 0)->select();
        if (empty($res)) {
            db('sc_collect')->insert([
                'user_id' => $this->userInfo['id'],
                'pro_id' => $pid,
                'created_time' => time()
            ]);
        } else {
            db('sc_collect')->where('user_id', $this->userInfo['id'])->where('pro_id', $pid)->update(['delete_time' => time()]);
        }

    }

//我的收藏列表
    public function mycollection()
    {
        $pagesize = input('get.pageSize', 10, 'intval');
        $page = input('get.page', 1, 'intval');
        $offset = ($page - 1) * $pagesize;
        $mycoll = db('sc_collect')
            ->alias('c')
            ->leftJoin('sc_product p', 'c.pro_id=p.id')
            ->field('p.id,p.imgs,p.title,p.sale_num,p.price')
            ->where('user_id', $this->userInfo['id'])
            ->limit($offset, $pagesize)
            ->select();
        if (empty($mycoll)) {
            $this->ajaxReturn(['error_code' => 1, 'msg' => '您还没有收藏商品，去逛逛吧']);
        } else {
            $this->ajaxReturn(['error_code' => 0, 'data' => ['col_list' => $mycoll]]);
        }
    }

    //我的优惠券列表
    public function mycoupon()
    {

        $pagesize = input('get.pageSize', 10, 'intval');
        $page = input('get.page', 1, 'intval');
        $offset = ($page - 1) * $pagesize;
        $coupon_list = db('sc_user_coupon')
            ->alias('uc')
            ->leftJoin('sc_coupon c', 'uc.coupon_id=c.id')
            ->where('uc.delete_time', 0)
            ->where('uc.user_id', $this->userInfo['id'])
            ->field('c.money,c.cut_money')
            ->limit($offset, $pagesize)
            ->select();
        $this->ajaxReturn(['error_code' => 0, 'data' => ['my_col' => $coupon_list]]);
    }

    //收藏与取消收藏
    public function collPor()
    {
        $pid = input('post.id', 0, 'intval');
        $res = db('sc_collect')->where('user_id', $this->userInfo['id'])->where('pro_id', $pid)->find();
        if (empty($res)) {
            db('sc_collect')->insert([
                'user_id' => $this->userInfo['id'],
                'pro_id' => $pid
            ]);
        } else {

            db('sc_collect')->where('user_id', $this->userInfo['id'])->where('pro_id', $pid)->delete();
        }

        $this->ajaxReturn(['error_code' => 0, 'msg' => '操作成功']);
    }

    //用户下单接口
    public function downOrder()
    {
        $pid = input('post.pid', 0, 'intval');
        $num = input('post.num', 1, 'intval');
        $price = db('sc_product')->where('id', $pid)->find();

        $oId = db('sc_order')->insertGetId(
            [
                'user_id' => $this->userInfo['id'],
                'pro_id' => $pid,
                'num' => $num,
                'status' => 0,
                'pay_money' => $price['price'] * $num
            ]
        );

        //返回刚刚下单id
        $this->ajaxReturn(['error_code' => 0, 'data' => ['o_id' => $oId]]);

    }

    //用户支付接口
    public function payMoney()
    {
        $oid = input('post.o_id', 0, 'intval');//订单id
        $cid = input('post.c_id', 0, 'intval');//优惠券id
        if (empty($oid) || empty($cid)) {
            $this->ajaxReturn(['error_code' => 1, 'msg' => '参数错误1']);
        }
        $rescid =
            db('sc_user_coupon')
                ->alias('uc')
                ->leftJoin('sc_coupon c','uc.coupon_id=c.id')
                ->where('uc.id', $cid)
                ->field('c.money,c.cut_money')
                ->find();
        $resoid = db('sc_order')->where('id', $oid)->where('status', 0)->find();
        if (empty($rescid) || empty($resoid)) {
            $this->ajaxReturn(['error_code' => 1, 'msg' => '参数错误2']);
        }
        if ($rescid['money'] > $resoid['pay_money']) {
            $this->ajaxReturn(['error_code' => 1, 'msg' => '参数错误,请勿乱修改前端数据']);
        }

        Db::startTrans();
        try {
            db('sc_user')->where('id', $this->userInfo['id'])->setDec('money', ($resoid['pay_money'] - $rescid['cut_money']));
            db('sc_order')->where('id', $oid)->update(['status' => 1]);
            db('sc_user_coupon')->where('id',$cid)->setDec('num',1);
            Db::commit();
        } catch (\Exception $e) {
            $this->ajaxReturn(['error_code' => 1, 'msg' => '参数错误,请勿乱修改前端数据']);
        }

        $this->ajaxReturn(['error_code' => 0, 'msg' => '购买成功，等待发货']);


    }


}