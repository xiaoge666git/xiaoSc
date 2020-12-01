<?php


namespace app\coupon\controller;


use library\Controller;

class UserCoupon extends Controller
{
    protected $table='sc_user_coupon';
    public function index(){
        $this->title='优惠券列表';
        $this->_query($this->table)
            ->equal('user_id,coupon_id')
            ->page();
    }

    protected function _index_page_filter(&$data){
        foreach ($data as &$vo){

            $vo['created_time']=date('Y-m-d H:i:s', $vo['created_time']);

            $resu=db('sc_user')->where('id',$vo['user_id'])->where('delete_time',0)->find();
            $vo['user_name']=$resu['name'];

            $resc=db('sc_coupon')->where('id',$vo['coupon_id'])->where('delete_time',0)->find();
            $vo['cou_title']=$resc['title'];
        }
    }
}