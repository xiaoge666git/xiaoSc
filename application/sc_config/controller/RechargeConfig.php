<?php


namespace app\sc_config\controller;


use library\Controller;

class RechargeConfig extends Controller
{
    protected $table='sc_recharge_config';
    public function index()
    {
        $this->title = 'vip配置管理';
        $this->_query($this->table)

            ->timeBetween('created_time')
            ->page();
    }

    /**
     * author:XSC
     * date 2020/12/1 0001 14:10
     *轮播图编辑
     *** @throws \think\Exception
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     * @throws \think\exception\PDOException
     */
    public function edit()
    {
        $this->applyCsrfToken();
        if ($this->request->isGet()) {
            $this->_form($this->table, 'form');
        } else {
            $data['updated_time'] = time();
            $this->_form($this->table,
                'form', '', '', $data);
        }
    }

    /**
     * 添加轮播
     * @auth true
     * @throws \think\Exception
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     * @throws \think\exception\PDOException
     */
    public function add()
    {
        $this->applyCsrfToken();
        if ($this->request->isGet()) {
            $this->_form($this->table, 'form');
        } else {
            $data['created_time'] = time();

            $this->_form($this->table, 'form', '', '', $data);
        }

    }
    /**
     * 删除轮播
     * @auth true
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function remove()
    {
        $this->applyCsrfToken();
        $this->_delete($this->table);
    }
}