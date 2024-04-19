Callback

2022年2月9日

18:55

 

> 1.前：
>
> *\<*HipTableColumnpropertyName=\"speciman\"prefWidth=\"273.0\"text=\"标本\"*\>*
>
> *\<*tableCell*\>*
>
> *\<*HipEtsTableCell dictCode=\"Speciman\"*/\>*
>
> *\</*tableCell*\>*
>
> *\</*HipTableColumn*\>*
>
>  
>
> 后：
>
>  
>
> *\<*HipTableTextCell*\>*
>
> *\<*toText*\>*
>
> *\<*DictElementCodeToText dictCode=\"Speciman\"*/\>*
>
> *\</*toText*\>*
>
> *\</*HipTableTextCell*\>*
>
>  
>
>  

1.  前：

> *\<!\--\<HipEtsFilterableComboBoxFormCellprefWidth=\"230\"propertyName=\"crowdClass\"GridPane.columnIndex=\"5\"GridPane.rowIndex=\"2\"GridPane.columnSpan=\"3\"dictCode=\"CVA01.00.002\"/\>\--\>*
>
> 后：
>
> *\<*HipCustomDataSourceFilterableComboBoxFormCell prefWidth=\"230\"propertyName=\"crowdClass\"GridPane.columnIndex=\"5\"GridPane.rowIndex=\"2\"GridPane.columnSpan=\"3\"*\>*
>
> *\<*customDataSourceCallback*\>*
>
> *\<*DictCodeElementDataSource dictCode=\"CVA01.00.002\"*\>\</*DictCodeElementDataSource*\>*
>
> *\</*customDataSourceCallback*\>*
>
> *\</*HipCustomDataSourceFilterableComboBoxFormCell*\>*
>
>  

1.  代码

> Map*\<*String,Object*\>* param=new HashMap*\<\>()*;
>
> param.put*(*\"event\",event*)*;
>
>  
>
> ActionEvent event = *(*ActionEvent*)*map.get*(*\"event\"*)*;
>
> HipButton hipButton = (HipButton)event.getSource();
>
>  
>
>  
>
> LoginUserInfo loginUserInfo=HipContextManager.*getFWBean(*LoginUserInfo.class*)*;
>
>  
>
>  
>
>  
