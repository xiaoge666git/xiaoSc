<?php


namespace app\api\controller;


class Product extends Base
{
    //商品列表
    public function index()
    {
        $status = input('get.status', 0, 'intval');//0所有  1拼团 2秒杀商品 3热卖产品
        $pagesize = input('get.pageSize', 10, 'intval');
        $page = input('get.page', 1, 'intval');
        $offset = ($page - 1) * $pagesize;

        $query = db('sc_product')
            ->where('delete_time', 0)
            ->where('status', 0)
            ->limit($offset, $pagesize)
            ->field('id,title,imgs,price,sale_num');
        $res = [];
        if ($status == 0) {
            $res = $query->select();
        }
        if ($status == 1) {
            $res = $query->where('is_group', 1)->select();
        }
        if ($status == 2) {
            $res = $query->where('is_seckill', 1)->select();
        }
        if ($status == 3) {
            $res = $query->order('sale_num desc')->select();
        }

        $rtData['error_code'] = 0;
        $rtData['data']['product'] = $res;
        $this->ajaxReturn($rtData);
    }

    public function searchPro()
    {
//        $pagesize = input('get.pageSize', 100000000, 'intval');
//        $page = input('get.page', 1, 'intval');
        $keyword = input('get.keyword', '', 'trim');
        $type = input('get.type', 0, 'intval');//0综合 1最新 2价格低到高排序 3价格高到低排序

//        $offset = ($page - 1) * $pagesize;
        $query = db('sc_product')
            ->field('id,title,imgs,price')
            ->where('delete_time', 0)
            ->where('status', 0)
//            ->limit($offset, 100000000)
            ->where('title', 'like', '%' . $keyword . '%');
        if ($type == 0) {
            $res = $query->select();
        } elseif ($type == 1) {
            $res = $query->order('created_time desc')->select();

        } elseif ($type == 2) {
            $res = $query->order('price')->select();
        } elseif ($type == 3) {
            $res = $query->order('price desc')->select();
        } else {
            $rtData['error_code'] = 1;
            $rtData['msg'] = '参数错误';
            $this->ajaxReturn($rtData);
        }
        $rtData['error_code'] = 0;
        $rtData['data']['product'] = $res;
        $this->ajaxReturn($rtData);
    }

    //获取商品信息 下单界面
    public function proInfo()
    {

        //isCollect
        $id = input('get.id', 0, 'intval');
        $res = db('sc_product')
            ->where('id', $id)
            ->where('delete_time', 0)
            ->where('status', 0)
            ->field('id,title,describe,sale_num,detail,price')
            ->find();

        $imgarr = explode('|', $res['detail']);
        $res['detail'] = $imgarr;
        $res['describe']=strip_tags( $res['describe']);
        $isCollect=db('sc_collect')->where('user_id',$this->userInfo['id'])->where('pro_id',$id)->where('delete_time',0)->count();
        $res['isCollect']=boolval($isCollect);
        $rtData['error_code'] = 0;

        $rtData['data']['product'] = $res;
        $this->ajaxReturn($rtData);
    }

    //未付款order的信息展示
    public function noPayOrder(){
  //用户电话及地址信息
        $oid=input('get.oid',0,'intval');

        $user=[
            'nick_name'=>$this->userInfo['nick_name'],
            'phone'=>$this->userInfo['phone'],
            'address'=>$this->userInfo['address'],

        ];
        $order=db('sc_order')
            ->alias('o')
            ->leftJoin('sc_product p','o.pro_id=p.id')
            ->field('p.imgs,p.title,p.price,p.size,o.pay_money,o.num,p.id pid,o.id oid')
            ->where('o.id',$oid)
            ->find();
        if ($order['size'] == 0) {
            $order['size'] = 'S';
        }

        if ($order['size'] == 1) {
            $order['size'] = 'N';
        }
        if ($order['size'] == 2) {
            $order['size'] = 'L';
        }
        if ($order['size'] == 3) {
            $order['size'] = 'XL';
        }
        if ($order['size'] == 4) {
            $order['size'] = 'XXL';
        }

        $coupon=db('sc_user_coupon')
            ->alias('uc')
            ->leftJoin('sc_coupon c','uc.coupon_id=c.id')
            ->where('c.money','<=',$order['pay_money'])
            ->where('uc.num','>',0)
            ->field('uc.id,c.money,c.cut_money')
            ->select();
        $this->ajaxReturn(['error_code'=>0,'data'=>['user'=>$user,'order'=>$order,'coupon'=>$coupon]]);
    }

}