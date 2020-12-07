<?php


namespace app\api\controller;


use app\api\validate\User;

class My extends Base
{
    //用户信息编辑
    public function edit()
    {
        $nick_name = input('post.nick_name', '', 'trim');
        $sex = input('post.sex', '', 'intval');
        $head_img = input('post.head_img', '', 'trim');
//        var_dump($nick_name);
//        die();
        $vauser = validate('user');
        if ($vauser->scene('edit')->check(['nick_name' => $nick_name]) && ($sex == 1 || $sex == 2)) {
            db('sc_user')->where('id', $this->userInfo['id'])->update(['nick_name' => $nick_name, 'sex' => $sex, 'profile_picture' => $head_img]);
            $this->ajaxReturn(['error_code' => 0, 'msg' => "编辑成功"]);

        } else {
            $this->ajaxReturn(['error_code' => 1, 'msg' => '编辑错误']);
        }
    }

}