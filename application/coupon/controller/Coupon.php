<?php

namespace app\coupon\controller;

use library\Controller;
use think\Db;

class Coupon extends Controller
{
    protected $table = 'sc_coupon';

    public function index()
    {
        $this->title = '优惠券管理';
        $this->_query($this->table)
            ->where('delete_time', '=', 0)
            ->like('title')
            ->equal('product_id')
            ->page();
    }

    /**
     * 数据列表处理
     * @param array $data
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    protected function _index_page_filter(&$data)
    {

        foreach ($data as &$vo) {
            $res = db('sc_product')->where('id', $vo['product_id'])->find();
            $vo['product_title'] = $res['title'];
        }
    }


    public function add()
    {
        $this->applyCsrfToken();
        if ($this->request->isGet()) {
            $this->_form($this->table, 'form');
        } else {
            $pid = $this->request->post('product_id');
            $res=db('sc_product')->where('id',$pid)->where('delete_time',0)->find();
            if(empty($res)){
                $this->error('没有该商品');
            }
            $data['created_time'] = time();
            $this->_form($this->table, 'form', '', '', $data);
        }
    }


    public function edit()
    {
        $this->applyCsrfToken();
        if ($this->request->isGet()) {
            $this->_form($this->table, 'form');
        } else {
            $pid = $this->request->post('product_id');
            $res=db('sc_product')->where('id',$pid)->where('delete_time',0)->find();
            if(empty($res)){
                $this->error('没有该商品');
            }
            $data['updated_time'] = time();
            $this->_form($this->table, 'form', '', '', $data);
        }
    }


    /**
     * 删除优惠券信息
     * @auth true
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function remove()
    {
        $this->applyCsrfToken();
        $id = $this->request->post('id');
        db('sc_user_coupon')->where('coupon_id', $id)->update(['delete_time' => time()]);
        $this->_save($this->table, ['delete_time' => time()]);
    }
}