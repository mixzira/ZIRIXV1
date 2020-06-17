local cfg = {}

cfg.groups = {
	["mindmaster"] = {
		_config = {
			title = "MindMaster"
		},
		"mindmaster.permissao"
	},
	["administrador"] = {
		_config = {
			title = "Administrador(a)"
		},
		"administrador.permissao"
	},
	["moderador"] = {
		_config = {
			title = "Moderador(a)"
		},
		"moderador.permissao"
	},
	["suporte"] = {
		_config = {
			title = "Suporte"
		},
		"suporte.permissao"
	},
	-----------------------------------------------------------------------------
	--[	Departamento de Justiça ]------------------------------------------------
	-----------------------------------------------------------------------------
	["juiz"] = {
		_config = {
			title = "Juiz(a)",
			gtype = "job"
		},
		"juiz.permissao",
	},
	["procurador"] = {
		_config = {
			title = "Procurador(a)",
			gtype = "job"
		},
		"procurador.permissao",
	},
	["promotor"] = {
		_config = {
			title = "Promotor(a)",
			gtype = "job"
		},
		"promotor.permissao",
	},
	["defensor"] = {
		_config = {
			title = "Defensor(a) Público",
			gtype = "job"
		},
		"defensor.permissao",
	},
	["advogado"] = {
		_config = {
			title = "Advogado(a)",
			gtype = "adv"
		},
		"advogado.permissao"
	},
	-----------------------------------------------------------------------------
	--[	Departamento de Policia ]------------------------------------------------
	-----------------------------------------------------------------------------
	["dpla"] = {
		_config = {
			title = "DPLA",
			gtype = "job"
		},
		"dpla.permissao",
	},
	["paisana-dpla"] = {
		_config = {
			title = "Paisana DPLA",
			gtype = "job"
		},
		"paisana-dpla.permissao",
	},

	["chefe-policia"] = {
		_config = {
			title = "Chefe de Polícia",
			gtype = "hie"
		},
		"chefe-policia.permissao"
	},
	["sub-chefe-policia"] = {
		_config = {
			title = "Sub Chefe de Polícia",
			gtype = "hie"
		},
		"sub-chefe-policia.permissao"
	},
	["inspetor"] = {
		_config = {
			title = "Inspetor de Polícia",
			gtype = "hie"
		},
		"inspetor.permissao"
	},
	["capitao"] = {
		_config = {
			title = "Capitão de Polícia",
			gtype = "hie"
		},
		"capitao.permissao"
	},
	["tenente"] = {
		_config = {
			title = "Tenente de Polícia",
			gtype = "hie"
		},
		"tenente.permissao"
	},
	["sub-tenente"] = {
		_config = {
			title = "Sub Tenente de Polícia",
			gtype = "hie"
		},
		"sub-tenente.permissao"
	},
	["um-sargento"] = {
		_config = {
			title = "1º Sargento de Polícia",
			gtype = "hie"
		},
		"um-sargento.permissao"
	},
	["dois-sargento"] = {
		_config = {
			title = "2º Sargento de Polícia",
			gtype = "hie"
		},
		"dois-sargento.permissao"
	},
	["agente-policia"] = {
		_config = {
			title = "Agente de Polícia",
			gtype = "hie"
		},
		"agente-policia.permissao"
	},
	["recruta-policia"] = {
		_config = {
			title = "Recruta de Polícia",
			gtype = "hie"
		},
		"recruta-policia.permissao"
	},
	-----------------------------------------------------------------------------
	--[	Departamento Médico ]----------------------------------------------------
	-----------------------------------------------------------------------------
	["dmla"] = {
		_config = {
			title = "DMLA",
			gtype = "job"
		},
		"dmla.permissao",
	}, 
	["paisana-dmla"] = {
		_config = {
			title = "Paisana DMLA",
			gtype = "job"
		},
		"paisana-dmla.permissao"
	},
	
	["diretor-geral"] = {
		_config = {
			title = "Diretor Geral",
			gtype = "hie"
		},
		"diretor-geral.permissao"
	},
	["diretor-auxiliar"] = {
		_config = {
			title = "Diretor Auxiliar",
			gtype = "hie"
		},
		"diretor-auxiliar.permissao"
	},
	["medico-chefe"] = {
		_config = {
			title = "Médico Chefe",
			gtype = "hie"
		},
		"medico-chefe.permissao"
	},
	["medico-cirurgiao"] = {
		_config = {
			title = "Médico Cirurgião",
			gtype = "hie"
		},
		"medico-cirurgiao.permissao"
	},
	["medico-aulixiar"] = {
		_config = {
			title = "Médico Auxiliar",
			gtype = "hie"
		},
		"medico-aulixiar.permissao"
	},
	["medico"] = {
		_config = {
			title = "Médico",
			gtype = "hie"
		},
		"medico.permissao"
	},
	["paramedico"] = {
		_config = {
			title = "Paramédico",
			gtype = "hie"
		},
		"paramedico.permissao"
	},
	["enfermeiro"] = {
		_config = {
			title = "Enfermeiro",
			gtype = "hie"
		},
		"enfermeiro.permissao"
	},
	["socorrista"] = {
		_config = {
			title = "Socorrista",
			gtype = "hie"
		},
		"socorrista.permissao"
	},
	["estagiario"] = {
		_config = {
			title = "Estágiario",
			gtype = "hie"
		},
		"estagiario.permissao"
	},
	-----------------------------------------------------------------------------
	--[	Taxista ]----------------------------------------------------------------
	-----------------------------------------------------------------------------
	["taxista"] = {
		_config = {
			title = "Taxista",
			gtype = "job"
		},
		"taxista.permissao"
	},
	["paisana-taxista"] = {
		_config = {
			title = "Taxista de folga",
			gtype = "job"
		},
		"paisana-taxista.permissao"
	},
	-----------------------------------------------------------------------------
	--[	Mecânico e Bennys ]------------------------------------------------------
	-----------------------------------------------------------------------------
	["mecanico"] = {
		_config = {
			title = "Mêcanico",
			gtype = "job"
		},
		"mecanico.permissao"
	},
	["paisana-mecanico"] = {
		_config = {
			title = "Mecânico de folga",
			gtype = "job"
		},
		"paisana-mecanico.permissao"
	},
	["bennys"] = {
		_config = {
			title = "Mecânico de Customs",
			gtype = "hie"
		},
		"bennys.permissao"
	},	
	-----------------------------------------------------------------------------
	--[	Organização de produção e venda de drogas ]------------------------------
	-----------------------------------------------------------------------------
	["ballas"] = {
		_config = {
			title = "Membro dos Ballas",
			gtype = "job",
		},
		"ballas.permissao"
	},
	["lider-ballas"] = {
		_config = {
			title = "Líder dos Ballas",
			gtype = "hie",
		},
		"lider-ballas.permissao"
	},
	-----------------------------------------------------------------------------
	--[	Organização de produção e venda de drogas ]------------------------------
	-----------------------------------------------------------------------------
	["grove"] = {
		_config = {
			title = "Membro da Grove",
			gtype = "job",
		},
		"grove.permissao"
	},
	["lider-grove"] = {
		_config = {
			title = "Líder da Grove",
			gtype = "hie",
		},
		"lider-grove.permissao"
	},
	-----------------------------------------------------------------------------
	--[	Organização de produção e vendas de armas ]------------------------------
	-----------------------------------------------------------------------------
	["medellin"] = {
		_config = {
			title = "Membro Medellín",
			gtype = "job",
		},
		"medellin.permissao"
	},
	["lider-medellin"] = {
		_config = {
			title = "Líder Medellín",
			gtype = "hie",
		},
		"lider-medellin.permissao"
	},
	-----------------------------------------------------------------------------
	--[	Organização de produção e vendas de armas ]------------------------------
	-----------------------------------------------------------------------------
	["motoclub"] = {
		_config = {
			title = "Membro Motoclub",
			gtype = "job",
		},
		"oc-guns02.permissao"
	},
	["lider-motoclub"] = {
		_config = {
			title = "Presidente Motoclub",
			gtype = "hie",
		},
		"lider-motoclub.permissao"
	},
	-----------------------------------------------------------------------------
	--[	Organização de lavagem de dinheiro ]-------------------------------------
	-----------------------------------------------------------------------------
	["bratva"] = {
		_config = {
			title = "Membro Bratva",
			gtype = "job",
		},
		"bratva.permissao"
	},
	["lider-bratva"] = {
		_config = {
			title = "Chefão Bratva",
			gtype = "hie",
		},
		"lider-bratva.permissao"
	},
	-----------------------------------------------------------------------------
	--[	Organização de lavagem de dinheiro ]-------------------------------------
	-----------------------------------------------------------------------------
	["odebrecht"] = {
		_config = {
			title = "Membro Odebrecht",
			gtype = "job",
		},
		"odebrecht.permissao"
	},
	["diretor-odebrecht"] = {
		_config = {
			title = "Diretor Odebrecht",
			gtype = "hie",
		},
		"diretor-odebrecht.permissao"
	}	
}

cfg.users = {
	[1] = { "mindmaster" }
}

cfg.selectors = {}

return cfg