<?php


namespace app\product\controller;


use library\Controller;

class ProductType extends Controller
{
    protected $table = 'sc_product_category';

    /**
     * 商品分类管理
     * @auth true
     * @menu true
     * @throws \think\Exception
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     * @throws \think\exception\PDOException
     */
    public function index()
    {
        $this->title = '商品分类管理';
        $query = $this->_query($this->table)->like('title')->equal('status');
        $query->where(['delete_time' => '0'])->order('id desc')->page();
    }

    /**
     * 添加商品分类
     * @auth true
     * @throws \think\Exception
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     * @throws \think\exception\PDOException
     */
    public function add()
    {
        $this->title = '添加商品分类';
        $this->_form($this->table, 'form','','',['created_time'=>time()]);
    }

    /**
     * 编辑商品分类
     * @auth true
     * @throws \think\Exception
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     * @throws \think\exception\PDOException
     */
    public function edit()
    {
        $this->title = '编辑商品分类';
        $this->_form($this->table, 'form','','',['created_time'=>time()]);
    }

    /**
     * 禁用商品分类
     * @auth true
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function forbid()
    {   //同时也下架该分类下的商品
        $proType=$this->request->post('id');

        db('sc_product')->where('cate_id','eq',intval($proType))->update(['status'=>1]);
        $this->_save($this->table, ['status' => '1']);
    }

    /**
     * 启用商品分类
     * @auth true
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function resume()
    {
        $this->_save($this->table, ['status' => '0']);
    }

    /**
     * 删除商品分类
     * @auth true
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function remove()
    {
        $this->applyCsrfToken();
        $this->_save($this->table,['delete_time'=>time()]);
    }

}