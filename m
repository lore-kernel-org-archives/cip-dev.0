Return-Path: <SRS0=vW+8=B3=lists.cip-project.org=bounce+64572+5126+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72FAC433DF
	for <cip-dev@archiver.kernel.org>; Mon, 17 Aug 2020 15:19:17 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 358EA205CB
	for <cip-dev@archiver.kernel.org>; Mon, 17 Aug 2020 15:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="vmZ3d4Mn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358EA205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5126+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id muXyYY4521723xxW0PCNptcc; Mon, 17 Aug 2020 08:19:16 -0700
X-Received: from david.siemens.de (david.siemens.de [192.35.17.14])
 by mx.groups.io with SMTP id smtpd.web12.45176.1597677554554142644
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Aug 2020 08:19:16 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 07HFJCmX011928
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2020 17:19:12 +0200
X-Received: from [167.87.134.109] ([167.87.134.109])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07HFJ9RI030165;
	Mon, 17 Aug 2020 17:19:11 +0200
Subject: Re: [cip-dev] [isar-cip-core] security-customizations: Recipe to apply security configurations
From: "Jan Kiszka" <jan.kiszka@siemens.com>
To: venkata.pyla@toshiba-tsip.com
Cc: cip-dev@lists.cip-project.org, cip-security@lists.cip-project.org
References: <20200805130412.1427-1-venkata.pyla@toshiba-tsip.com>
 <d9c4ec47-3bfd-bf76-976e-28c3225096b0@siemens.com>
Message-ID: <20ae8e8c-fded-c2ee-517a-d1f077f3224b@siemens.com>
Date: Mon, 17 Aug 2020 17:19:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <d9c4ec47-3bfd-bf76-976e-28c3225096b0@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: eaLu449Wi8G2fiRaWLdce3Qvx4520388AA=
Content-Type: multipart/mixed; boundary="gytgZF5AL1RuhDkzMRgS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597677556;
 bh=9GQowfAqFl5d5w/iftCVRh5zIRE415AaAg/1VGs8dWM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=vmZ3d4MnNk4W8gOoSGNn++vfwY7QIVx8F0ua2AP7kj+ERKMRLhBZSL3eDqPLfMimmOC
 HzGAJZm/QoYBaNXUBXNB9JekYlbyRXDuegM3q3dy/0zXkyPgqLRORxS9RzoowADOMITOF
 PC2/9ZcJB1uyqr4Bu8LmfwHtSLP2KW+pKMQ=

--gytgZF5AL1RuhDkzMRgS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 17.08.20 14:47, Jan Kiszka wrote:
> On 05.08.20 15:04, venkata.pyla@toshiba-tsip.com wrote:
>> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>
>> This recipe will apply security policies* to the reference image
>> that will be used for IEC62443-4-2 Evaluation
>>
>> *Security policies:
>>  1. Enforcing strong password to user accounts
>>  2. Lock user accounts for failed login attempts
>>  3. Terminate remote session for inactive time period
>>  4. Limit the concurrent login sessions
>>  5. Warn audit stroage failure
>>
>> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
>> ---
>>  .../images/cip-core-image-security.bb         |  2 +-
>>  .../security-customizations/files/postinst    | 51 +++++++++++++++++++
>>  .../security-customizations.bb                | 18 +++++++
>>  3 files changed, 70 insertions(+), 1 deletion(-)
>>  create mode 100644 recipes-core/security-customizations/files/postinst
>>  create mode 100644 recipes-core/security-customizations/security-customizations.bb
>>
>> diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
>> index a17c522..61ddc39 100644
>> --- a/recipes-core/images/cip-core-image-security.bb
>> +++ b/recipes-core/images/cip-core-image-security.bb
>> @@ -13,7 +13,7 @@ inherit image
>>  
>>  DESCRIPTION = "CIP Core image including security packages"
>>  
>> -IMAGE_INSTALL += "customizations"
>> +IMAGE_INSTALL += "security-customizations"
>>  
>>  # Debian packages that provide security features
>>  IMAGE_PREINSTALL += " \
>> diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
>> new file mode 100644
>> index 0000000..3699ba2
>> --- /dev/null
>> +++ b/recipes-core/security-customizations/files/postinst
>> @@ -0,0 +1,51 @@
>> +#!/bin/sh
>> +#
>> +# CIP Security, generic profile
>> +# Security Package configurations
>> +#
>> +
>> +echo "CIP Core Security Image (login: root/root)" > /etc/issue
>> +
>> +HOSTNAME=demo
>> +echo "$HOSTNAME" > /etc/hostname
>> +echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
>> +
>> +# CR1.7: Strength of password-based authentication
>> +# Pam configuration to  enforce password strength
>> +PAM_PWD_FILE="/etc/pam.d/common-password"
>> +pam_cracklib_config="password  requisite    pam_cracklib.so retry=3 minlen=8 maxrepeat=3 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1  difok=3 gecoscheck=1 reject_username  enforce_for_root"
>> +if grep -c "pam_cracklib.so" "${PAM_PWD_FILE}";then
>> +        sed -i '/pam_cracklib.so/ s/^#*/#/'  "${PAM_PWD_FILE}"
>> +fi
>> +sed -i "0,/^password.*/s/^password.*/${pam_cracklib_config}\n&/" "${PAM_PWD_FILE}"
>> +
>> +# CR1.11: Unsuccessful login attempts
>> +# Lock user account after unsuccessful login attempts
>> +PAM_AUTH_FILE="/etc/pam.d/common-auth"
>> +pam_tally="auth   required  pam_tally2.so  deny=3 even_deny_root unlock_time=60 root_unlock_time=60"
>> +if grep -c "pam_tally2.so" "${PAM_AUTH_FILE}";then
>> +        sed -i '/pam_tally2/ s/^#*/#/'  "${PAM_AUTH_FILE}"
>> +fi
>> +sed -i "0,/^auth.*/s/^auth.*/${pam_tally}\n&/" "${PAM_AUTH_FILE}"
>> +
>> +# CR2.6: Remote session termination
>> +# Terminate remote session after inactive time period
>> +SSHD_CONFIG="/etc/ssh/sshd_config"
>> +alive_interval=$(sed -n '/ClientAliveInterval/p' "${SSHD_CONFIG}")
>> +alive_countmax=$(sed -n '/ClientAliveCountMax/p' "${SSHD_CONFIG}")
>> +sed -i "/${alive_interval}/c ClientAliveInterval 120"  "${SSHD_CONFIG}"
>> +sed -i "/${alive_countmax}/c ClientAliveCountMax 0" "${SSHD_CONFIG}"
>> +
>> +# CR2.7: Concurrent session control
>> +# Limit the concurrent login sessions
>> +LIMITS_CONFIG="/etc/security/limits.conf"
>> +echo "* hard maxlogins 2" >> ${LIMITS_CONFIG}
>> +
>> +# CR2.9: Audit storage capacity
>> +# CR2.9 RE-1: Warn when audit record storage capacity threshold reached
>> +AUDIT_CONF_FILE="/etc/audit/auditd.conf"
>> +sed -i 's/space_left_action = .*/space_left_action = SYSLOG/'  $AUDIT_CONF_FILE
>> +sed -i 's/admin_space_left_action = .*/admin_space_left_action = SYSLOG/' $AUDIT_CONF_FILE
>> +
>> +# CR2.10: Response to audit processing failures
>> +sed -i 's/disk_error_action = .*/disk_error_action = SYSLOG/' $AUDIT_CONF_FILE
>> diff --git a/recipes-core/security-customizations/security-customizations.bb b/recipes-core/security-customizations/security-customizations.bb
>> new file mode 100644
>> index 0000000..dbb06d9
>> --- /dev/null
>> +++ b/recipes-core/security-customizations/security-customizations.bb
>> @@ -0,0 +1,18 @@
>> +#
>> +# CIP Security, generic profile
>> +#
>> +# Copyright (c) Toshiba Corporation, 2020
>> +#
>> +# Authors:
>> +#  Venkata Pyla <venkata.pyla@toshiba-tsip.com>#
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +inherit dpkg-raw
>> +
>> +DESCRIPTION = "CIP Security image for IEC62443-4-2 evaluation"
>> +
>> +SRC_URI = " file://postinst"
>> +

Was missing

DEPENDS = "sshd-regen-keys"

Added this, CI should be passing now. I suspect you tested over a
non-clean build with leftovers that papered over it.

Jan

>> +DEBIAN_DEPENDS = "sshd-regen-keys"
>>
> 
> Thanks, applied to next.
> 
> Jan
> 

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

--gytgZF5AL1RuhDkzMRgS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5126): https://lists.cip-project.org/g/cip-dev/message=
/5126
Mute This Topic: https://lists.cip-project.org/mt/76006733/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--gytgZF5AL1RuhDkzMRgS--
