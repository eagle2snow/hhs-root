package ${package};

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ${idaoPackage};
import ${entityPackage};
import ${iservicPackage};
import com.gm.base.dao.IBaseDao;
import com.gm.service.impl.BaseServiceImpl;

@Transactional
@Service("${entityName}Sercive")
public class ${entitySimpleName}ServiceImpl extends BaseServiceImpl<${entitySimpleName}, Integer> implements I${entitySimpleName}Service {
	@Resource
	private I${entitySimpleName}Dao dao;

	@Override
	public IBaseDao<${entitySimpleName}, Integer> getDao() {
		return dao;
	}
}