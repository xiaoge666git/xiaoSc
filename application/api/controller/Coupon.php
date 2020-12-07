<?php


namespace app\api\controller;


class Coupon extends Base
{
    //优惠券列表
    public function index()
    {
        $res = db('sc_coupon')
            ->where('delete_time', 0)
            ->field('id,title,money,cut_money')
            ->select();
        $rtData['error_code'] = 0;
        $rtData['data']['coupon'] = $res;
        $this->ajaxReturn($rtData);
    }
}