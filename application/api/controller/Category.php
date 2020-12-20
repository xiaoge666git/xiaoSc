<?php


namespace app\api\controller;


class Category extends Base
{
    protected $table = 'sc_product_category';

    //衣服分类接口
    public function index()
    {
        $res = db($this->table)
            ->field('id,title')
            ->where('status', 0)
            ->select();
        $rtData['error_code'] = 0;
        $rtData['data']['category'] = $res;
        $this->ajaxReturn($rtData);
    }

    //根据分类id获取商品
    public function catePro()
    {
        $cate_id = input('get.cate_id', 0, 'intval');
        $pagesize = input('get.pagesize', 10, 'intval');
        $page = input('get.page', 1, 'intval');
        $offset = ($page - 1) * $pagesize;
        if ($cate_id == 0) {
            $rtData['error_code'] = 1;
            $rtData['msg'] = '参数错误';
            $this->ajaxReturn($rtData);
        }
        $res = db('sc_product')
            ->where('status', 0)
            ->where('cate_id', $cate_id)
            ->where('delete_time', 0)
            ->field('id,title,imgs as p_img,price')
            ->limit($offset, $pagesize)
            ->select();
        $rtData['error_code'] = 0;
        $rtData['data']['pro_list'] = $res;
        $this->ajaxReturn($rtData);
    }


}