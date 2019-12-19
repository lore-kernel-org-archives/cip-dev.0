From: michael.adler@siemens.com (Adler, Michael)
Date: Thu, 19 Dec 2019 13:01:34 +0000
Subject: [cip-dev] [cip-core:deby] failed switching to "builder":
 operation not permitted
In-Reply-To: <TYAPR01MB2285448766788F6F71B0E29AB7520@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <20191219130134.5nr7rihfor52ukhy@demogorgon>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

> However the GitLab runner we use was upgraded to a newer version since your last build.

yep, that's the reason. The new runners respect the container's entrypoint (i.e. the entrypoint script is begin executed on a CI run). In other words, there shouldn't be any reason to execute /kas/docker-entrypoint from within gitlab-ci.yml.

Kind regards,
  Michael

--
Michael Adler
Siemens AG, Corporate Technology, CT RDA IOT SES-DE, Otto-Hahn-Ring 6, 81739 Munich, Germany

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Gerhard Cromme
Managing Board: Joe Kaeser, Chairman, President and Chief Executive Officer; Roland Busch, Lisa Davis, Klaus Helmrich, Janina Kugel, Siegfried Russwurm, Ralf P. Thomas
Registered offices: Berlin and Munich, Germany
Commercial registries: Berlin Charlottenburg, HRB 12300, Munich, HRB 6684
WEEE-Reg.-No. DE 23691322
