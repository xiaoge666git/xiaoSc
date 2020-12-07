<?php


namespace app\api\controller;


class Vip extends Base
{
    public function VipConfig()
    {
        $res = db('sc_vip_config')
            ->where('delete_time', 0)
            ->field('id,price,days')
            ->select();
        $rtData['error_code'] = 0;
        $rtData['data']['coupon'] = $res;
        $this->ajaxReturn($rtData);
    }

}