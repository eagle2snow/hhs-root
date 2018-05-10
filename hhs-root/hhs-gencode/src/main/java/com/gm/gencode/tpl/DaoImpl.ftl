package ${package};

import org.springframework.stereotype.Repository;

import ${idaoPackage};
import ${entityPackage};
import com.gm.base.dao.impl.BaseDaoImpl;

/**
 * 代码生成器生成代码<br/>
 * ${entitySimpleName}DaoImpl
 * @author guet
 *
 */

@Repository
public class ${entitySimpleName}DaoImpl extends BaseDaoImpl<${entitySimpleName}, Integer> implements I${entitySimpleName}Dao {

}