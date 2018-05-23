package com.gm.base.model;

import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.gm.gencode.annotation.FormField;
import com.gm.gencode.annotation.M;
import com.gm.gencode.util.FieldType;

@M("分销树")
@Entity(name = "distributionTree")
@Table(name = "t_distribution_tree")
@SuppressWarnings("serial")
public class DistributionTree extends Model {

	//mu.setfId("1");  
    //mu.setName("会员昵称");  
    //mu.setPid("0");  
	@FormField(label = "父id", type = FieldType.TEXTINPUT)
	private String fid;
	
	@FormField(label = "下级id", type = FieldType.TEXTINPUT)
    private String pId;
    
    @FormField(label = "会员昵称", type = FieldType.TEXTINPUT)
    private String name;


	public String getFid() {
		return fid;
	}

	
	public void setFid(String fid) {
		this.fid = fid;
	}

	public String getpId() {
        return pId;
    }

    public void setpId(String pId) {
        this.pId = pId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

   

}
