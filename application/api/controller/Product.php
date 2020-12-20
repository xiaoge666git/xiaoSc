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


}