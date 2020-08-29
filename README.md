# Ten-bar truss
使用Matlab計算出十桿衍架個元素的應力及位移，並使用fminocn進行最佳化分析
- v2.m
    進行有限元素計算
- nonlcon.m
    帶入v2.m所得到的應力及位移矩陣，得到非線性條件
- object.m
    目標函數: 整體結構的質量
- main.m
    將各條件帶入fminocn進行最佳化分析
