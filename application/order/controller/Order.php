<?php

namespace app\order\controller;

use library\Controller;

class Order extends Controller
{
    protected $table = 'sc_order';

    public function index()
    {
        $this->title = '订单管理';
        $this->_query($this->table)
            ->equal('id,user_id,pro_id,status')
            ->order('created_time desc')
            ->page();

    }

    protected function _index_page_filter(&$data)
    {
        foreach ($data as &$val) {
            $val['created_time'] = date('Y-m-d H:i:s', $val['created_time']);
            $resu = db('sc_user')->where('id', $val['user_id'])->find();
            $val['name'] = $resu['name'];
            $resp = db('sc_product')->where('id', $val['pro_id'])->find();
            $val['title'] = $resp['title'];
        }
    }

    //发货
    public function shipments()
    {
        $this->applyCsrfToken();
        $this->_save($this->table, ['status' => 2]);

    }
}