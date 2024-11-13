![高效能.jpg](https://pic.pimg.tw/ofeyhong/1613462939-2186891434-g.jpg "高效能.jpg")

**Win10有三種電源模式：省電、平衡、高效能**  
省電模式只有筆電會用，桌機預設是平衡模式，但我通常會建議用高效能模式，因為桌機沒有省電的問題，當然是要高效能。  
 

![【Win10優化】開啟終極效能    (電源計劃)](https://pic.pimg.tw/ofeyhong/1613462508-3348219353-g.jpg "【Win10優化】開啟終極效能    (電源計劃)")  
你可以試著調整平衡或高效能，CPU的速度會有變化。

其實WIN10還有一個隱藏的「終極效能」，需要特殊指令開啟，請看以下說明。

![【Win10優化】開啟終極效能    (電源計劃)](https://pic.pimg.tw/ofeyhong/1613392652-2346764462-g.jpg "【Win10優化】開啟終極效能    (電源計劃)")  
**Step01：****左下開始(右鍵)→Windows Powershell(系統管理員)**

![終極效能.jpg](https://pic.pimg.tw/ofeyhong/1613462809-2942324870-g.jpg "終極效能.jpg")  
**Step02：****輸入以下指令 (請直接COPY貼上)  
```powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61**```

![終極效能.jpg](https://pic.pimg.tw/ofeyhong/1613462212-1875152685-g.jpg "終極效能.jpg")  
**Step03：****終極效能就出來了**

  
如果你的是筆電，請不要用終極效能，因為耗電。

如果你的是桌機，可以試試終極效能，你可以注意一下CPU風扇的風切聲，如果你是用原裝風扇，應該可以聽到風扇轉速變快了，如果是塔扇那應該感覺不出來有什麼差別。

其實這個終極效能的意思說穿了就是強迫CPU在高時脈下工作，至於到底有沒要差別，你可以試試看，網上的評測是說有10%左右的提昇。

#### 常用命令

```
高效能 powercfg -duplicatescheme 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c

省電 powercfg -duplicatescheme a1841308-3541-4fab-bc81-f71556f20b4a

終極效能 powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61

平衡 powercfg -duplicatescheme 381b4222-f694-41f0-9685-ff5bb260df2e

1. 列出所有的電源計劃：
powercfg /L
2. 選擇要刪除選項的GUID:
powercfg -delete {GUID}
```