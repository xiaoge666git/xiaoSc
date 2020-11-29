<?php

namespace app\user\controller;


use library\Controller;
use think\Db;

class Member extends Controller
{
    protected $table = "sc_user";

    public function index()
    {
        $this->title = '用户管理';
        $this->_query($this->table)
            ->like('name')
            ->equal('sex,is_vip')
            ->timeBetween('created_time')
            ->page();
    }

    public function remove()
    {
        $this->applyCsrfToken();
        $this->_delete($this->table);
    }

    protected function _edit_form_filter(&$vo)
    {
        if ($this->request->get()) {
            $vo['created_time'] = date('Y-m-d H:i:s', $vo['created_time']);

        }
    }

    public function edit()
    {

        $this->applyCsrfToken();
        $this->_form($this->table, 'form');
    }

    public function banned()
    {
        $this->applyCsrfToken();
        $this->_save($this->table, ['status' => 1]);
    }


}