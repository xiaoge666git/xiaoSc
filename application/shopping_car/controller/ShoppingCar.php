<?php

namespace app\shopping_car\controller;

use library\Controller;

class ShoppingCar extends Controller
{
    protected $table='sc_shopping_car';
    public function index(){
        $this->title='购物车列表';
        $this->_query($this->table)
            ->equal('user_id,pro_id')
            ->page();
    }

    protected function _index_page_filter(&$data){
        foreach ($data as &$vo){

            $vo['created_time']=date('Y-m-d H:i:s', $vo['created_time']);

            $resu=db('sc_user')->where('id',$vo['user_id'])->where('delete_time',0)->find();
            $vo['user_name']=$resu['name'];

            $resp=db('sc_product')->where('id',$vo['pro_id'])->where('delete_time',0)->find();
            $vo['pro_title']=$resp['title'];
        }
    }

}