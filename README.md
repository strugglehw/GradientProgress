# GradientProgress
swift 5实现的渐变颜色的圆环进度条
实例：

        let gpView = GradientProgressView();
        //默认是黑色，结合要用的情景设置背景
        gpView.backgroundColor = UIColor.white
        
        //设置渐变的方向
        gpView.gradientStart = .leftTop
        //设置渐变的颜色组
        gpView.gradientColors = [UIColor.yellow,UIColor.blue,UIColor.red];
