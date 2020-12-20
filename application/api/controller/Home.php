<?php


namespace app\api\controller;


class Home extends Base
{

    public function index()
    {
//        var_dump($this->userInfo);
//        die();
//轮播图
        $banner = db('sc_banner')
            ->where('delete_time', 0)
            ->limit(4)
            ->field('id,p_id,img_url banner_img')
            ->select();

        //优惠券
        $coupon = db('sc_coupon')
            ->where('delete_time', 0)
            ->limit(3)
            ->field('id c_id,img coupon_img')
            ->select();

        //hot_product 热卖推荐商品
        $hot = db('sc_product')
            ->where('status', 0)
            ->where('delete_time', 0)
            ->limit(9)
            ->field('id p_id,imgs pro_img,price,title')
            ->select();

        //for_you_product:[//为你精选
        $forYou = db('sc_product')
            ->where('status', 0)
            ->where('delete_time', 0)
            ->limit(12)
            ->field('id p_id,imgs pro_img,price,title   ')
            ->select();


        $rtData['error_code'] = 0;
        $rtData['data']['banner'] = $banner;
        $rtData['data']['coupon'] = $coupon;
        $rtData['data']['hot_product'] = $hot;
        $rtData['data']['for_you_product'] = $forYou;

        $this->ajaxReturn($rtData);

    }
}