<?php

namespace app\student\controller;

use app\company\service\DataService;
use library\Controller;
use think\Db;

class Index extends Controller
{
    protected $table = 'student';

    public function index()
    {
        $class = Db::table('s_class')->select();

        $this->assign('class', $class);
        $this->title = '学生管理';
        $query = $this->_query('student')->alias('s');
        $query->join('s_class c', 's.c_id=c.id')->field('s.id,s.s_id,s.name,s.sex,s.create_at,s.c_id,c.class_name')->like('name,c_id')->equal('s_id,sex')->page();
    }


    public function add()
    {
        if ($this->request->isGet()) {
            //也可用通过 data_modal 弹出一个班级选项框
            $this->applyCsrfToken();
            $class = Db::table('s_class')->select();
            $this->assign('class', $class);

            $this->_form($this->table, 'from');
        } else {
            $this->applyCsrfToken();
            $s_id = Db::table('student')
                ->where('s_id', '=', $_POST['s_id'])
                ->find();
            if (!empty($s_id)) {
                $this->error('学号重复');
            }
            $this->_form($this->table, 'from');
        }


    }

    public function edit()
    {
        $class = Db::table('s_class')->select();
        $this->assign('class', $class);
        $this->applyCsrfToken();
        $this->_form('student', 'from');
    }
    public function remove()
    {
        $this->_delete($this->table);
    }



}