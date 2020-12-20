<?php


namespace app\api\controller;


use think\Db;

class Coupon extends Base
{
    //优惠券列表
    public function index()
    {
//        $a=1;
//        ++$a;
//        var_dump($a);
//        die();

        $pagesize = input('get.pageSize', 10, 'intval');
        $page = input('get.page', 1, 'intval');
        $offset = ($page - 1) * $pagesize;
        $res = db('sc_coupon')
            ->where('delete_time', 0)
            ->field('id,title,money,cut_money')
            ->limit($offset, $pagesize)
            ->select();
        $rtData['error_code'] = 0;
        $rtData['data']['coupon'] = $res;
        $this->ajaxReturn($rtData);
    }

//领取优惠券
    public function getCoupon()
    {
        $id = input('post.coupon_id', 0, 'intval');
        if ($id == 0) {
            $rtData['error_code'] = 1;
            $rtData['msg'] = '参数错误';
            $this->ajaxReturn($rtData);
        }

        $res = db('sc_user_coupon')->where('user_id', $this->userInfo['id'])->where('coupon_id', $id)->find();

        if (!empty($res)) {
            Db::startTrans();
            try {
                db('sc_user_coupon')->where('user_id', $this->userInfo['id'])->where('coupon_id', $id)->setInc('num');
                db('sc_coupon')->where('id', $id)->setDec('num');
                Db::commit();
                $rtData['error_code'] = 0;
                $rtData['msg'] = '领取成功';
                $this->ajaxReturn($rtData);
            } catch (\Exception $e) {
                $rtData['error_code'] = 1;
                $rtData['msg'] = '领取失败';
                $this->ajaxReturn($rtData);
            }
        } else {

            Db::startTrans();
            try {
                Db::table('sc_user_coupon')->insert([
                    'user_id' => $this->userInfo['id'],
                    'coupon_id' => $id,
                    'num'=>1,
                    'created_time'=>time()
                ]);
                Db::table('sc_coupon')->where('id', $id)->setDec('num');
                Db::commit();
                $rtData['error_code'] = 0;
                $rtData['msg'] = '领取成功';
                $this->ajaxReturn($rtData);
            } catch (\Exception $e) {
                $rtData['error_code'] = 1;
                $rtData['msg'] = '领取失败';
                $this->ajaxReturn($rtData);
            }


        }

    }
}