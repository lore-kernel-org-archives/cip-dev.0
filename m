Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE94CC433EF
	for <webhook@archiver.kernel.org>; Fri,  1 Jul 2022 11:34:07 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.87])
 by mx.groups.io with SMTP id smtpd.web11.36767.1656675245489244837
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Jul 2022 04:34:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Jegp/nj2;
 spf=pass (domain: siemens.com, ip: 40.107.20.87,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1G73MjRyI+kDCq9Ok6ltlYir0hIGuwGBReJ9Fcf1uRbSbm63e1SASbc8AR+uBf1kxK7zpKjtm5o+Swrc3vzYs7DADPMmMeRb5LtK8W0Ox2puK/n70Pz2KtcaGQH8OfTTGVhGGjIJp7Q1oXkm5pTCAa01pJbvI81nGmEgZ3NgmBiK9BQGHpkw2nlTKP3YA7zzVAhfWT6LLUWMg3ERVOimu//yPQG7cs7jye2IE4VgzqaEbryL3HVwpjCTq1HP0CrYWtWRwjaABPu2QWrdgJH+avGVGAHI+cqdlETLV884SGk2e+3xb6h2KeMa8UQXSM0vz3QM3rGG+N36clso36GRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcrC96vE9trZjLttDSf96wkwOwFvIELzfSD8Al6bXqU=;
 b=THX5vvRCkT49YObYZ/7Pe8O5XO2HHI6DyyEupaNnyeq1GMHArWrEytTrJGni2m42Gi+d9krVYLEVKogW2JKJV1R1gFZpNfFiZlvBmzXTy+5KgsqWa4j2C0sHm9ydNvbULqqQTP0qLRkqfFv5H/oc6KIAnz5wCV0oZkUBaegGX6xRBDrYXRWSnOVYam/crSAJKxttXLkVarNW1pnsi0VgfUONIaoksBJLecFnl5w5mCpMMLhwg4/5nDfmuSYgXWpan3Bz3v2oiQBOd9n6iwxMvV31XA+21NNvlQYL3LL5Frt+Kftgc3LwjIsYW4jpG1EepD1f85INwbz8ddJSL3HdxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 194.138.21.70) smtp.rcpttodomain=toshiba-tsip.com
 smtp.mailfrom=siemens.com; dmarc=temperror action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qcrC96vE9trZjLttDSf96wkwOwFvIELzfSD8Al6bXqU=;
 b=Jegp/nj29SGKZGMvYdQU5WvDq4NgX3Ib1tnMiFjOkxcE8yvgfifHRPd00ZuTOXpl26ry0Vc3oem9ynHQq3OBKbJ6vxRdSmSQb78a2lnnHorS7IFLpFpTPNMxW3wCYP0HwgNpk4314DFl3Fc8ivGtO8JRjv8VqtnXOz5ZTS9B/j57bd3U8+Gyypxdgwc/JutTw5NwDR4noCDLmycx3UvQsZdC2PQi8UgskBEpra+y2yb6RhpVU7oYHfwke5VY38PXkhDJGzBEUbZS/xq5QORCIkjHDs+YqoX3QdAC9B+2OW9J17cq9pnDRS223pWhECH9mjq2H0rK+Pr0qHf0KddWog==
Received: from OS6P279CA0007.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:30::8) by
 DB8PR10MB3879.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.15; Fri, 1 Jul 2022 11:34:03 +0000
Received: from HE1EUR01FT020.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:30:cafe::c3) by OS6P279CA0007.outlook.office365.com
 (2603:10a6:e10:30::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Fri, 1 Jul 2022 11:34:02 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 194.138.21.70) smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=siemens.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of siemens.com: DNS Timeout)
Received: from hybrid.siemens.com (194.138.21.70) by
 HE1EUR01FT020.mail.protection.outlook.com (10.152.0.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14 via Frontend Transport; Fri, 1 Jul 2022 11:34:01 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Fri, 1 Jul 2022 13:34:00 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Fri, 1 Jul 2022
 13:34:00 +0200
Message-ID: <00a35fff-97ff-e94a-2b6e-b2bda6231f90@siemens.com>
Date: Fri, 1 Jul 2022 13:33:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [isar-cip-core] postinst:Added lines to verify Local and Remote
 Multi-factor Authentication
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <Shreyas.Karmahe@toshiba-tsip.com>, <yes@arc11.toshiba.co.jp>,
	<cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <venkata.pyla@toshiba-tsip.com>,
	<kazuhiro3.hayashi@toshiba.co.jp>
References: <yes> <20220630112644.3682066-1-Shreyas.Karmahe@toshiba-tsip.com>
 <446fe1e4-eaca-f920-3750-cbea068a8347@siemens.com>
In-Reply-To: <446fe1e4-eaca-f920-3750-cbea068a8347@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--18.482900-8.000000
X-TMASE-MatchedRID: MWBePzxHDOwhz+KjBN9OubZv+ayzmKtKPg9yfk4YC0Z59UIqyNDq+Q/o
	5bNHEsCTV7MQTbTl028i5/9hlXY2r+CvRZnq77KlA32djEHOWJqcwDdLDXDKeT8Ckw9b/GFehnC
	FIAQefsjoU8g9IMz+h0gOYX1vhvgM47CMV9e94vyyCtXR476v1Ad1O2DSI1kjHli0ghrWY9ty4V
	FP6muDhmL3wjohBdrXlSU7uH1tms4aUiTYmfzyKRgfPeUgZ+/2yE/8+I8+t0czL6MySEJ0Vi45o
	jdE7FAWAQe1ufITXxwljwv16q1U/mDvcgl6gHxp2FTfVSZnASBT+JmnZwrj3F5hVZTm4dD8QX5C
	VimNCmkGxrhW/sejDZg39Rgsjteo4vM1YF6AJbZFi+KwZZttL7ew1twePJJB3QfwsVk0UbtuRXh
	7bFKB7h+GGP8gkEZBiWElQx0p5/I1C8i+xBNyE+dVi68f9BLVlExlQIQeRG0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.482900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 2993E4EC84F164E529B3E7FCF5F4186343F5612CABA1DADE9CD8D332DAEF568D2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1e83709-4b3d-41c5-bdb9-08da5b55984f
X-MS-TrafficTypeDiagnostic: DB8PR10MB3879:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0PnMXJMuTJe3Kb3V06inT+CbxPK/z29zu03uZOlX7GK2Z+sp0WnG3PGVSXr/rn2KCamw3vbkGWhcrg73uniwH+yxleMQuGGO5ytpWZQ7JCjIajrD9PdthjQhbNomRQPZc/2/LSiQ3KLTyoAnuMOdmOKEZyQFDKuYbhtcYxVhlqsargY2uVZb/v1PlBwL6JviWsiXgVHF5bS7MJl3LISUhG01BdfZ7AS7qKi4KThWdkmQay4JMTyJxFgnEL+Rp3+EeiexsxNuJrz3S7Y6ofx1gvDsfTH3qq/DlkTRqoRyuEsHPlng/r+WraRWGRQdOhP5fX15N8oMW0gWYMlpcPLlmFLmVH7CJWQHJPyZ18vWsxgwAN7Q3xRnJwESjd5thc/61wqvRseiVlzavRD8zFuKKRFs8dTZaIzgkgbS3plhQDxr8PMyUbCG1u5Mi1Wp/PbfH2r1IduvD88CaiijSVo+pet/CiDkNgfnB0HPSth/ftR6QXEY6mO40N5Q4wMIayglGteUs/dFA4szUFTIWXWbbGlPNeCKhh+7j1sWsCuhjIYP3Du/bzpq2Yhn1ytRvt31DwdrRYEQTTx8WZmtNs9XhfQMTi8nPkiZicbgmXJDONLUhjKV5M7xadeWbOMXJKXKyMV9deIGNVl7lxy348O4UWb6jhXoEHDfctA9VGREE1t+Dliw46wbBGjNcsuAMJRBVhoUOTzX7nMtYB4HYCR3Em+h7zhZSm5edGvogvDaqcKpnkj8wgcQ9XMeyDZ88LsS46LYR1iVf705+dBJGlow4WRWMGvEy/Uh01f4+448xi1ZT2wECo22QNoXRqreaXu122IlCa5u7fS0QRW8GOvDZ+nopZIh6ZzlM6O/C4gYS0I9KX0VjRhJLfBYFPM7j8x8NK/Wlsy2iyMGbbvgXH3ZR57Zqrg6Ezsd9hGbMinGL4g=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(136003)(376002)(36840700001)(40470700004)(46966006)(478600001)(4326008)(70206006)(70586007)(44832011)(36860700001)(36756003)(40480700001)(82310400005)(63350400001)(63370400001)(54906003)(110136005)(8936002)(8676002)(5660300002)(31686004)(316002)(6706004)(83380400001)(16576012)(81166007)(15650500001)(82740400003)(2616005)(26005)(956004)(336012)(53546011)(16526019)(47076005)(186003)(2906002)(82960400001)(356005)(40460700003)(31696002)(41300700001)(86362001)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 11:34:01.1213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c1e83709-4b3d-41c5-bdb9-08da5b55984f
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT020.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3879
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 Jul 2022 11:34:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8632

On 01.07.22 13:32, Jan Kiszka wrote:
> On 30.06.22 13:26, Shreyas.Karmahe@toshiba-tsip.com wrote:
>> From: Shreyas Karmahe <Shreyas.Karmahe@toshiba-tsip.com>
>>
>> To enable and configure PAM for Remote and Local MFA Session Verification
>>
>> Signed-off-by: Shreyas Karmahe <Shreyas.Karmahe@toshiba-tsip.com>
>> ---
>>  .../security-customizations/files/postinst        | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
>> index bb7d15b..843ce3c 100644
>> --- a/recipes-core/security-customizations/files/postinst
>> +++ b/recipes-core/security-customizations/files/postinst
>> @@ -15,7 +15,8 @@ echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
>>  PAM_PWD_FILE="/etc/pam.d/common-password"
>>  pam_cracklib_config="password  requisite    pam_cracklib.so retry=3 minlen=8 maxrepeat=3 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1  difok=3 gecoscheck=1 reject_username  enforce_for_root"
>>  if grep -c "pam_cracklib.so" "${PAM_PWD_FILE}";then
>> -        sed -i '/pam_cracklib.so/ s/^#*/#/'  "${PAM_PWD_FILE}"
>> +        
>> +sed -i '/pam_cracklib.so/ s/^#*/#/'  "${PAM_PWD_FILE}"

And an accidental change here?

>>  fi
>>  sed -i "0,/^password.*/s/^password.*/${pam_cracklib_config}\n&/" "${PAM_PWD_FILE}"
>>  
>> @@ -49,3 +50,15 @@ sed -i 's/admin_space_left_action = .*/admin_space_left_action = SYSLOG/' $AUDIT
>>  
>>  # CR2.10: Response to audit processing failures
>>  sed -i 's/disk_error_action = .*/disk_error_action = SYSLOG/' $AUDIT_CONF_FILE
>> +
>> +# CR2.11: Enable Mutli Factor Authentication for Local and Remote Session
>> +SSHD_AUTH_CONFIG="/etc/pam.d/common-auth"
>> +google_authenticator="auth required pam_google_authenticator.so nullok"
>> +if grep -c "pam_google_authenticator.so" "${SSHD_AUTH_CONFIG}";then
>> +		sed -i '/pam_google_authenticator.so/ s/^#*/#/'  "${SSHD_AUTH_CONFIG}"
>> +fi
>> +#sed -i "0,/^auth.*/s/^auth.*/${google_authenticator}\n&/" "${SSHD_AUTH_CONFIG}"
> 
> Dead code? Or forgotten to activate?
> 
>> +echo "auth required pam_google_authenticator.so nullok" | tee -a "${SSHD_AUTH_CONFIG}"
>> +# Enable PAM configuration for Remote Session
>> +sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' "${SSHD_CONFIG}"
>> +echo "AuthenticationMethods keyboard-interactive" | tee -a "${SSHD_CONFIG}"
> 

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

