<?php


namespace app\api\controller;


use think\App;
use think\console\command\optimize\Schema;

class ShoppingCar extends Base
{
    public function __construct(App $app)
    {
        parent::__construct($app);
    }

    //购物车列表
    public function index()
    {
        $res = db('sc_shopping_car')
            ->alias('c')
            ->leftJoin('sc_product p', 'p.id=c.pro_id')
            ->where('c.delete_time', 0)
            ->field('c.id c_id,p.imgs p_img,p.title p_title,p.price,c.num')
            ->select();
        if (empty($res)) {
            $rtData['error_code'] = 1;
            $rtData['data']=[];
        $this->ajaxReturn($rtData);
        }
        $rtData['error_code'] = 0;
        $rtData['data']['will_buy_pro']=$res;
        $this->ajaxReturn($rtData);


    }

    //添加购物车
    public function add()
    {

        $p_id = input('post.id', 0, 'intval');
        $p_num = input('post.num', 0, 'intval');
        if ($p_id == 0 || $p_num == 0) {
            $rtData['error_code'] = 1;
            $rtData['msg'] = '参数错误';
            $this->ajaxReturn($rtData);
        }
        $data = [
            'user_id' => $this->userInfo['id'],
            'pro_id' => $p_id,
            'num' => $p_num,
        ];

        //是否已经添加商品 已经添加的话就增加数据
        $isHave = db('sc_shopping_car')
            ->where('delete_time', 0)
            ->where('user_id', $data['user_id'])
            ->where('pro_id', $p_id)
            ->find();

        if (empty($isHave)) {
            db('sc_shopping_car')->insert($data);
        } else {
            db('sc_shopping_car')
                ->where('id', $isHave['id'])
                ->setInc('num', $p_num);

        }

        $rtData['error_code'] = 0;
        $rtData['msg'] = '添加购物车成功';
        $this->ajaxReturn($rtData);

    }
}