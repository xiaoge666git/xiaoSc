<?php

namespace app\product\controller;

use library\Controller;
use library\tools\Data;
use think\Db;

class Product extends Controller
{
    protected $table = 'sc_product';


    /**
     * 商品信息管理
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
        $this->title = '商品信息管理';
        $query = $this->_query($this->table)
            ->equal('status,cate_id')
            ->like('title');
        $query->where(['delete_time' => '0'])
            ->order('id desc')
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
        $this->clist = Db::name('sc_product_category')->where(['delete_time' => '0', 'status' => '0'])->select();
        foreach ($data as &$vo) {
            $vo['cate'] = [];
            foreach ($this->clist as $cate) {

                if ($cate['id'] == $vo['cate_id']) {
                    $vo['cate'] = $cate['title'];
                }
            }
        }

    }

    /**
     * 商品库存入库
     * @auth true
     * @throws \think\Exception
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     * @throws \think\exception\PDOException
     */
    public function stock()
    {
        if ($this->request->isGet()) {
            $GoodsId = $this->request->get('id');
            $goods = Db::name('StoreGoods')->where(['id' => $GoodsId])->find();
            empty($goods) && $this->error('无效的商品信息，请稍候再试！');
            $goods['list'] = Db::name('StoreGoodsList')->where(['goods_id' => $GoodsId])->select();
            $this->fetch('', ['vo' => $goods]);
        } else {
            list($post, $data) = [$this->request->post(), []];
            if (isset($post['id']) && isset($post['goods_id']) && is_array($post['goods_id'])) {
                foreach (array_keys($post['goods_id']) as $key) if ($post['goods_number'][$key] > 0) array_push($data, [
                    'goods_id' => $post['goods_id'][$key],
                    'goods_spec' => $post['goods_spec'][$key],
                    'number_stock' => $post['goods_number'][$key],
                ]);
                if (!empty($data)) {
                    Db::name('StoreGoodsStock')->insertAll($data);
                    \app\store\service\GoodsService::syncStock($post['id']);
                    $this->success('商品信息入库成功！');
                }
            }
            $this->error('没有需要商品入库的数据！');
        }
    }

    /**
     * 添加商品信息
     * @auth true
     * @throws \think\Exception
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     * @throws \think\exception\PDOException
     */
    public function add()
    {
        $this->title = '添加商品信息';
        $this->isAddMode = '1';
        $data['created_time'] = time();
        $this->_form($this->table, 'form', '', '', $data);
    }
    /**
     * 编辑商品信息
     * @auth true
     * @throws \think\Exception
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     * @throws \think\exception\PDOException
     */
    public function edit()
    {
        $this->title = '编辑商品信息';
        $this->isAddMode = '0';
        $data['updated_time'] = time();
        $this->_form($this->table, 'form', '', '', $data);
    }
    /**
     * 表单数据处理
     * @param array $data
     * @throws \think\Exception
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     * @throws \think\exception\PDOException
     */
    protected function _form_filter(&$data)
    {
        if ($this->request->isGet()) {
            $this->cates = Db::name('sc_product_category')->where(['delete_time' => '0', 'status' => '0'])->order('id desc')->select();
        } elseif ($this->request->isPost()) {
            if (empty($data['imgs'])) $this->error('商品LOGO不能为空，请上传图片');
            if (empty($data['title'])) $this->error('商品标题不能为空，请上传图片');
            if (empty($data['detail'])) $this->error('商品展示图片不能为空，请上传图片');
            if (empty($data['price'])) $this->error('商品价格不能为空，请上传图片');
            if (empty($data['vip_price'])) $this->error('商品vip价格不能为空，请上传图片');
        }
    }

    /**
     * 表单结果处理
     * @param boolean $result
     */
    protected function _form_result($result)
    {
        if ($result && $this->request->isPost()) {
            $this->success('商品编辑成功！', 'javascript:history.back()');
        }
    }

    /**
     * 禁用商品信息 下架
     * @auth true
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function forbid()
    {
        $this->_save($this->table, ['status' => '1']);
    }

    /**
     * 启用商品信息
     * @auth true
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function resume()
    {
        $this->_save($this->table, ['status' => '0']);
    }

    /**
     * 删除商品信息
     * @auth true
     * @throws \think\Exception
     * @throws \think\exception\PDOException
     */
    public function remove()
    {
        $this->applyCsrfToken();
        $this->_save($this->table, ['delete_time' => time()]);
    }

}