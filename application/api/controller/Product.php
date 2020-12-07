<?php


namespace app\api\controller;


class Product extends Base
{
    //商品列表
    public function index()
    {
        $status = input('get.status', 0, 'intval');//0所有  1拼团 2秒杀商品
        $pagesize = input('get.pageSize', 10, 'intval');
        $page = input('get.page', 1, 'intval');
        $offset = ($page - 1) * $pagesize;

        $query=db('sc_product')
            ->where('delete_time',0)
            ->where('status',0)
            ->limit($offset,$pagesize)
            ->field('id p_id,imgs p_img');
        $res=[];
        if ($status==0){
            $res=$query->select();
        }
        if ($status==1){
            $res=$query->where('is_group',1)->select();
        }
        if ($status==2){
            $res=$query->where('is_seckill',1)->select();
        }

        $rtData['error_code']=0;
        $rtData['data']['product']=$res;
        $this->ajaxReturn($rtData);


    }

}