# DSP

[toc]

## Script Classification
* `arterial_curve`
    * arterial_curve.m
    * arterial_curve_normalized.m
* `pulsewave signal process`
    * ptt.m
    * Kbp.m
    * freq_domain.m
    * Oscillometric.m
    * xiebishe.m
## Script Description
### arterial_curve
`描述了三位患者的理想动脉顺应性曲线以及血压波动状态的下的血管顺应性曲线`
#### output
![Image text](https://raw.githubusercontent.com/tt-loveslife/DSP/main/media/ppgvstp.png)
![Image text](https://raw.githubusercontent.com/tt-loveslife/DSP/main/media/compliance.png)
### arterial_curve_normalized
`在 arterial_curve.m 的基础上对数据进行了血管容积的标准化`
### ptt
`分析了静息、加压状态下，被测者脉搏波信号主波峰和重波峰之间距离以及三搏、四搏、五搏、六搏下的状态`
### freq_domain
`在 ptt.m 的基础上进行了频域分析`
### Oscillometric
`基于示波法对绘制脉搏波信号幅值的包络线，确定幅值最大处，确定血压值`
### xiebishe
`探究在不同外加压状态下，脉搏波波形和幅值变化过程`
#### output
![Image text](https://raw.githubusercontent.com/tt-loveslife/DSP/main/media/pressurevsamp.png)
