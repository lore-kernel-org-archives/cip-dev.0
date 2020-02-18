From: quirin.gylstorff@siemens.com (Gylstorff Quirin)
Date: Tue, 18 Feb 2020 17:20:01 +0100
Subject: [cip-dev] : isar-cip-core and cip-kernel-config
Message-ID: <ca39ce48-8602-0e79-99af-2f44200e2b12@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi all,

I am currently trying to have all targets in isar-cip-core running with 
the matching configuration from cip-kernel-config. For some targets 
there are missing config entries to boot Debian 10 e.g. [1].

Should I add these configuration directly to the matching defconfig in
cip-kernel-config or add new defconfig/snippets for isar-cip-core?

Currently I am adding them directly to the defconfigs as it is IHMO
more manageable as it avoid snippets/configs all over the place.

[1]: 
https://gitlab.com/Quirin.Gy/cip-kernel-config/-/commit/92979dba2e3c03a422b5b9e8f9c592db9ff43f30

-- 
Quirin Gylstorff

Siemens AG
Corporate Technology
Research in Digitalization and Automation
Smart Embedded Systems
CT RDA IOT SES-DE
Otto-Hahn-Ring 6
81739 Muenchen, Germany
Mobile: +49 173 3746683
mailto:quirin.gylstorff at siemens.com
www.siemens.com/ingenuityforlife

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim 
Hagemann Snabe; Managing Board: Joe Kaeser, Chairman, President and 
Chief Executive Officer; Roland Busch, Lisa Davis, Klaus Helmrich, 
Cedrik Neike, Michael Sen, Ralf P. Thomas; Registered offices: Berlin 
and Munich, Germany; Commercial registries: Berlin Charlottenburg, HRB 
12300, Munich, HRB 6684; WEEE-Reg.-No. DE 23691322

Important notice: This e-mail and any attachment thereof contain 
corporate proprietary information. If you have received it by mistake, 
please notify us immediately by reply e-mail and delete this e-mail and 
its attachments from your system. Thank you.
