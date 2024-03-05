Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F96C54E58
	for <webhook@archiver.kernel.org>; Tue,  5 Mar 2024 16:11:35 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web10.27144.1709655093636691668
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Mar 2024 08:11:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=dsCYpTk1;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-51332-20240305161131df98f0ef117ad34e79-ekoybt@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20240305161131df98f0ef117ad34e79
        for <cip-dev@lists.cip-project.org>;
        Tue, 05 Mar 2024 17:11:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=ck7Cebh16C7TNNM9oid2HHrpKkLwz1tnSuLl9M2541Y=;
 b=dsCYpTk1cz+bP2Vx2frypLfOeR/B3g6050DkBI6pRFRAfuBk1vUk3twyhfeqd2vQgjZrjb
 dIFfjcRQ5kW7yM7HvcFJYZOw68csw59jsJ0orZ2Z05h6MqaQhaB0mjOaT6ZTlpMyfnNSUZ0M
 F4ATFE0BF2cU8V71yOUSfEhfROgBw=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 6/6] format: classes/swupdate fix parenthesis
Date: Tue,  5 Mar 2024 17:10:59 +0100
Message-ID: <20240305161128.2777211-7-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240305161128.2777211-1-Quirin.Gylstorff@siemens.com>
References: <20240305161128.2777211-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Mar 2024 16:11:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15232

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate.bbclass | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 3bd0cbd..01295b0 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -63,7 +63,7 @@ IMAGE_TEMPLATE_VARS:swu = " \
 # TARGET_IMAGE_UUID needs to be generated before completing the template
 addtask do_transform_template after do_generate_image_uuid
 
-python do_extend_sw_description(){
+python do_extend_sw_description() {
     cmds = d.getVar("SWU_EXTEND_SW_DESCRIPTION")
     if cmds is None or not cmds.strip():
         return
@@ -74,7 +74,7 @@ python do_extend_sw_description(){
 do_transform_template[prefuncs] += "do_extend_sw_description"
 
 SWU_EXTEND_SW_DESCRIPTION += "add_swu_hw_compat"
-python add_swu_hw_compat(){
+python add_swu_hw_compat() {
     # create SWU_HW_COMPAT_NODE based on list of supported hw
     hw_compat = d.getVar('SWU_HW_COMPAT')
     if hw_compat:
@@ -86,7 +86,7 @@ python add_swu_hw_compat(){
 }
 
 SWU_EXTEND_SW_DESCRIPTION += "add_swu_compression"
-python add_swu_compression(){
+python add_swu_compression() {
     # create SWU_COMPRESSION_NODE node if compression is enabled
     calgo = d.getVar('SWU_COMPRESSION_TYPE')
     if calgo:
@@ -110,7 +110,7 @@ def add_scripts_to_src_uri(d):
 SRC_URI += "${@add_scripts_to_src_uri(d)}"
 
 SWU_EXTEND_SW_DESCRIPTION += "add_scripts_node"
-python add_scripts_node(){
+python add_scripts_node() {
     swu_scripts = d.getVar('SWU_SCRIPTS')
     if not swu_scripts:
         return
-- 
2.43.0


