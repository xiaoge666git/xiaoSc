<?php


namespace app\api\controller;


use app\api\validate\User;

class My extends Base
{
    //用户信息编辑
    public function edit()
    {
        $nick_name = input('post.nick_name', '', 'trim');
        $sex = input('post.sex', '', 'intval');
        $head_img = input('post.head_img', '', 'trim');
//        var_dump($nick_name);
//        die();
        $vauser = validate('user');
        if ($vauser->scene('edit')->check(['nick_name' => $nick_name]) && ($sex == 1 || $sex == 2)) {
            db('sc_user')->where('id', $this->userInfo['id'])->update(['nick_name' => $nick_name, 'sex' => $sex, 'profile_picture' => $head_img]);
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

        if (in_array($type, [-1.0, 1, 2, 3])) {
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
                    $item['size'] ='N';
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

}