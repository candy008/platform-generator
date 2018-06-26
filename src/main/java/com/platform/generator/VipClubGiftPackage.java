package com.platform.generator;

import java.io.Serializable;
import java.util.Date;




public class VipClubGiftPackage  implements Serializable{

	private static final long serialVersionUID = 1L;

	//
	private Long id;
	//礼包名称
	private String name;
	//发放开始时间
	private Date startTime;
	//发放截止时间
	private Date endTime;
	//礼包状态 0 待发放 1 发放中 2 已发放 3 已删除
	private Integer status;
	//领取时显示文案
	private String content;
	//礼包类型 1 自定义礼包 其他类型礼包延续数字
	private Integer type;
	//礼品类型， 1 礼包下只有优惠券  2  礼包下只有京豆 3 礼包下既有优惠券又有京豆
	private Integer selectType;
	//操作人
	private String creater;
	//修改人
	private String modifier;
	//创建时间
	private Date created;
	//修改时间
	private Date modified;
	//备用字段
	private String other;
	//礼包图片
	private String defaultImgUrl;
	//礼包图片
	private String openImgUrl;
	//要导入用户的文件
	private String pinFileName;

	//礼包包含的用户pin的数量
	private Integer giftPinNum;
	//已经领取的用户
	private Integer yiLingQuNum;

	public void setId(Long id){
		this.id =  id;
	}
	
	public Long getId(){
		return id;
	}

	public void setName(String name){
		this.name =  name;
	}
	
	public String getName(){
		return name;
	}

	public void setStartTime(Date startTime){
		this.startTime =  startTime;
	}
	
	public Date getStartTime(){
		return startTime;
	}

	public void setEndTime(Date endTime){
		this.endTime =  endTime;
	}
	
	public Date getEndTime(){
		return endTime;
	}

	public void setStatus(Integer status){
		this.status =  status;
	}
	
	public Integer getStatus(){
		return status;
	}

	public void setContent(String content){
		this.content =  content;
	}
	
	public String getContent(){
		return content;
	}

	public void setType(Integer type){
		this.type =  type;
	}
	
	public Integer getType(){
		return type;
	}

	public void setSelectType(Integer selectType){
		this.selectType =  selectType;
	}
	
	public Integer getSelectType(){
		return selectType;
	}

	public void setCreater(String creater){
		this.creater =  creater;
	}
	
	public String getCreater(){
		return creater;
	}

	public void setModifier(String modifier){
		this.modifier =  modifier;
	}
	
	public String getModifier(){
		return modifier;
	}

	public void setCreated(Date created){
		this.created =  created;
	}
	
	public Date getCreated(){
		return created;
	}

	public void setModified(Date modified){
		this.modified =  modified;
	}
	
	public Date getModified(){
		return modified;
	}

	public void setOther(String other){
		this.other =  other;
	}
	
	public String getOther(){
		return other;
	}

	public void setDefaultImgUrl(String defaultImgUrl){
		this.defaultImgUrl =  defaultImgUrl;
	}
	
	public String getDefaultImgUrl(){
		return defaultImgUrl;
	}

	public void setOpenImgUrl(String openImgUrl){
		this.openImgUrl =  openImgUrl;
	}
	
	public String getOpenImgUrl(){
		return openImgUrl;
	}

	public String getPinFileName() {
		return pinFileName;
	}

	public void setPinFileName(String pinFileName) {
		this.pinFileName = pinFileName;
	}

	public Integer getGiftPinNum() {
		return giftPinNum;
	}

	public void setGiftPinNum(Integer giftPinNum) {
		this.giftPinNum = giftPinNum;
	}

	public Integer getYiLingQuNum() {
		return yiLingQuNum;
	}

	public void setYiLingQuNum(Integer yiLingQuNum) {
		this.yiLingQuNum = yiLingQuNum;
	}

}