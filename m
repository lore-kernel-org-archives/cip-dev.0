Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FF2C43334
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 10:02:57 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.49])
 by mx.groups.io with SMTP id smtpd.web10.82544.1657015369303872935
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jul 2022 03:02:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=fEGOuAQD;
 spf=pass (domain: siemens.com, ip: 40.107.7.49,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMJ0CEQwsykzpX0nWC8miOdRe0i2W/z1l6dBA7QlZJVXaE19IulWwGmISpIgu5+3Jev2k84TTTjEjNFyBGDek4b+Wt0MrLMkS5XfgObRjUMOMC7T2Ld4QjXKF12JrDX8hXf2v00lxFt6TNryAvj3dn5r74dNYQbD+3pT8oP5FoJUVUWm9hwL8XcW4WKfETMeCx+bhNQrp/cHTYYseq0yOzaBCXTzGbG5oL5G+5XBIaNq3FEtkf9hf+shmgVH/XtaEDEZWyO1jHYlMIf1d6foKVwSgLtYpbbCatTq8VBJIl0T5MU4YYFQPrrScTsvO0ce65B9hER/yL7ebyxmgrgJOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4NaNuKwvEQTxDe9sJDssK8CADDSeX2SSPV2ysjWZns=;
 b=khC9EIDauwYmydu/CcRvRS/3llVeqaTvSKLdW1XnRMqL5sBL/XK0IHW9flITselDwq5ovq+AdoWcec43TrzQ+khvwGc/JX1/bd3rsQKu+tEqh8C2fB/HgNRk0K8M17B25Jy+s58aCByDag5KgfjPoyN6w8UMRNBD690kK+9/piB8GqqW32WPaAOOdjl53y/5vhzQ6QHdG3D9KwzCE2qauRcfsr5YqiX63PeF6/gHhwaVExFzLWhYFnbzU7D0fcx0kpIn4gbGWZZzbEN2JMjRgIspc8iFVtgaNISQiAoOgiOforhhMigT4CQ7b2L0QN/WG6YsOiLrhZO2u5SGhotJsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4NaNuKwvEQTxDe9sJDssK8CADDSeX2SSPV2ysjWZns=;
 b=fEGOuAQDRWTORUNG+LDCet6GxSci/nzcgv+jL/9wWiA04Wf/jNUo69/DRvgsXLGN4yKMe/O1pJR4VdvygPfoOcFD/cIN43ihxiCv1vgdzEv4VIaR62x4uphB/FfOl3MjukXQIVjPtphH7zZWs4WHQ66P0P1j2Kk5daayiGJvEyNAMygBeu+MXuoW6fElhcu7hImWQtBfTyyT5JeAIYlC0/FSQd7TmHhDiAA+gVY9QNrigum4r4u7eLseS2bXn78sMxTGWMurP9PUetFEWx4NtyTRtDZ85LOnDGWeCZSO8fX3yaQe3VQSbyC4OYLjtWbwfjgErFUyGfKnbNwA5H6rgQ==
Received: from SV0P279CA0041.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:13::10)
 by AM9PR10MB4513.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:26e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Tue, 5 Jul
 2022 10:02:46 +0000
Received: from HE1EUR01FT040.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:13:cafe::75) by SV0P279CA0041.outlook.office365.com
 (2603:10a6:f10:13::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Tue, 5 Jul 2022 10:02:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 HE1EUR01FT040.mail.protection.outlook.com (10.152.1.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14 via Frontend Transport; Tue, 5 Jul 2022 10:02:45 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 5 Jul 2022 12:02:44 +0200
Received: from [139.21.19.13] (139.21.19.13) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Tue, 5 Jul 2022
 12:02:44 +0200
Message-ID: <778b8eaa-a41e-459d-9523-ec48f32828f1@siemens.com>
Date: Tue, 5 Jul 2022 12:02:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [isar-cip-core] postinst:Added lines to verify Local and Remote
 Multi-factor Authentication
Content-Language: en-US
To: <Shreyas.Karmahe@toshiba-tsip.com>, <yes@arc11.toshiba.co.jp>,
	<cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <Venkata.Pyla@toshiba-tsip.com>,
	<kazuhiro3.hayashi@toshiba.co.jp>
References: <yes> <20220630112644.3682066-1-Shreyas.Karmahe@toshiba-tsip.com>
 <446fe1e4-eaca-f920-3750-cbea068a8347@siemens.com>
 <00a35fff-97ff-e94a-2b6e-b2bda6231f90@siemens.com>
 <OSZPR01MB88776F17082E85E3FB3A57ABDCBE9@OSZPR01MB8877.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <OSZPR01MB88776F17082E85E3FB3A57ABDCBE9@OSZPR01MB8877.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [139.21.19.13]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--21.373400-8.000000
X-TMASE-MatchedRID: 5gCJM1F5pVchz+KjBN9OuYldd8VMUiC5/k5m7D0YTS/x5KZMlKYS/QD4
	keG7QhHmPEcKSPm4wHQQBYB2SlRx+j2j2bXgCyW6EnbMkUwDMHu9TGmwrVcPS7xygpRxo469K/Y
	FZTiDf+qo2aAEiAd8COghU++ssgQWdps0hZoS9mJVmdpNbAWYI/oQsM4HC3IulVHM/F6YkvT+pa
	X6bXuNYVFbgxCd+zKG3gOL71QHycuyMOF99mGJHBHyJWk7t0yt6ng+QM4KwJQD2WXLXdz+AT+k5
	IvvZ1N/WMFR4yyN53ph6Dre803nhJENBoWeboxRMbzlN4ZzGg4rb1lxhdAELn0YWXpL5234gizN
	KnxrsXJp2y18eTT/bcXpKknBlVMHI7uqX/G4taz+ZyPCiB0OuWHjhWUsEu50Wxfo7yZZDqYFeeA
	jqMW+l/mrkkH6JvZBfZan2B1yXrmbKneFtGQ4N3iApyj4vq/foN+4RiCkxPZuXgIqq6mQyvRU+9
	PTPHSYp+5vzsY5mKNkM6EDjePJEszIEYdVcVQOX7bicKxRIU23sNbcHjySQd0H8LFZNFG7/nnwJ
	52QYi8hem0kmpPZMQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.373400-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 ADB272E6C195EE418384EFADF60C9031F9B2FF2AC042A3C857765E2F497FF5852000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67717f54-6247-49cc-fbec-08da5e6d822d
X-MS-TrafficTypeDiagnostic: AM9PR10MB4513:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	U/44Bs/4ZIyCkDgrqpMKOO0+yjQaCEqNFDE0t2g1aogx2iKUPDxOCD2xGXHgCe4fqqQi5aDajS5VNrwLgAgckFm7eq5zj2GS7MRKR7kAcRJbNDdYI33UlVBPEJgRQ5+YuKBrr5kPgsboJQ+Czw/vLOYd7O33VX3DKTieu+xN0QSdXm922SuqX26fls/Qsogo0sV61GlxeEdWfJp0VBZzSXzwd7kM2uPue6b2OpLMvqpYSbCRKcyAxQ+EQGUOMBDK0mSb0/YrD6ZlAmYfAYbmw5EDNfKLygMLoKISdl9gZtG5CXSlfWQTRBJC4MRHclenEg1rGdiBN76g8DFV8CaPed/jw7KfXw71InH00fii82ee9DRgkzoYdzsgo4dzt0JUWOOnNA86lQfsVuCGmlzpntOtjagGZak2vcO5IsbhUln0I0e0RxwHOlEzAYnc3sRZI1BJfrIsoHOb2Pr0TnfXGpSnd02/NxArfc1NbUkjE9kmJnty0+GHtCRd5qbjgbffI5UwTMbIShbLfmVFh5KSa6AmwSBHmgTXnsjv19Yvveg8FCH7aYCJKrg65fi3Dak4mQopGOnJ6SaRgsvhDLNGOfEM70YP5xj3QHaaeBWCUEJJkFLVUvpVx0j6DT3x4gCNe4IVd6PAxEh6TXVCUxohafmn+bMmnlLe+TTcK1JUqJpLGSQkrCI23j3aKLz+rmugN4K1FWlSY0sjboOMbHUcILzWc7NGuDcNclSESMleOPLgyM5ZUb5ippbG1ZBtH1uT95mcl1jtsHiQyCw2muKUa3JaXgl1eoVdJgpQzJN7IrNtHJ4DpwrSMdPksX9mNUHbHQWbKD5s44EYDC//o8aFEziynK826trKFIUnLLd1Blp7c85F+ECF6Z0Y4D7fs+XAZm1ipZfvCpvxIe/T2DHQe6D9qKbQOwOQYk0p8J5rpXw=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(376002)(136003)(46966006)(40470700004)(36840700001)(8936002)(5660300002)(478600001)(16526019)(186003)(26005)(40480700001)(956004)(2616005)(86362001)(53546011)(15650500001)(31696002)(2906002)(44832011)(336012)(47076005)(41300700001)(16576012)(6706004)(83380400001)(82310400005)(82740400003)(356005)(4326008)(82960400001)(70586007)(316002)(70206006)(8676002)(36860700001)(81166007)(110136005)(54906003)(36756003)(31686004)(40460700003)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 10:02:45.3975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 67717f54-6247-49cc-fbec-08da5e6d822d
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT040.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4513
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 10:02:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8681

On 04.07.22 18:51, Shreyas.Karmahe@toshiba-tsip.com wrote:
> Hi Jan,
>=20
> I have resend the patch again by removing the commented line from postins=
t file from security-customizations.
> The commenting line is dead code only and used for debugging purpose.
> Kindly review the following resend patch=20
>=20
> v2-0001-security-customizations-postinst-Add-configuratio.patch

Please read both of my replies and address the other one as well.

Thanks,
Jan

>=20
> Kind Regards,=20
> Shreyas
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>=20
> Sent: Friday, July 1, 2022 5:04 PM
> To: karmahe shreyas(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0) <Shreyas.Karmah=
e@toshiba-tsip.com>; yes@arc11.toshiba.co.jp; cip-dev@lists.cip-project.org
> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0) <dinesh.kumar@tosh=
iba-tsip.com>; pyla venkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG =
Porting) <Venkata.Pyla@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=
=8C=E5=AE=8F =E2=96=A1=EF=BC=B3=EF=BC=B7=EF=BC=A3=E2=97=AF=EF=BC=A1=EF=BC=
=A3=EF=BC=B4) <kazuhiro3.hayashi@toshiba.co.jp>
> Subject: Re: [isar-cip-core] postinst:Added lines to verify Local and Rem=
ote Multi-factor Authentication
>=20
> On 01.07.22 13:32, Jan Kiszka wrote:
>> On 30.06.22 13:26, Shreyas.Karmahe@toshiba-tsip.com wrote:
>>> From: Shreyas Karmahe <Shreyas.Karmahe@toshiba-tsip.com>
>>>
>>> To enable and configure PAM for Remote and Local MFA Session=20
>>> Verification
>>>
>>> Signed-off-by: Shreyas Karmahe <Shreyas.Karmahe@toshiba-tsip.com>
>>> ---
>>>  .../security-customizations/files/postinst        | 15 ++++++++++++++-
>>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/recipes-core/security-customizations/files/postinst=20
>>> b/recipes-core/security-customizations/files/postinst
>>> index bb7d15b..843ce3c 100644
>>> --- a/recipes-core/security-customizations/files/postinst
>>> +++ b/recipes-core/security-customizations/files/postinst
>>> @@ -15,7 +15,8 @@ echo "127.0.0.1 $HOSTNAME" >> /etc/hosts =20
>>> PAM_PWD_FILE=3D"/etc/pam.d/common-password"
>>>  pam_cracklib_config=3D"password  requisite    pam_cracklib.so retry=3D=
3 minlen=3D8 maxrepeat=3D3 ucredit=3D-1 lcredit=3D-1 dcredit=3D-1 ocredit=
=3D-1  difok=3D3 gecoscheck=3D1 reject_username  enforce_for_root"
>>>  if grep -c "pam_cracklib.so" "${PAM_PWD_FILE}";then
>>> -        sed -i '/pam_cracklib.so/ s/^#*/#/'  "${PAM_PWD_FILE}"
>>> +       =20
>>> +sed -i '/pam_cracklib.so/ s/^#*/#/'  "${PAM_PWD_FILE}"
>=20
> And an accidental change here?
>=20
>>>  fi
>>>  sed -i "0,/^password.*/s/^password.*/${pam_cracklib_config}\n&/" "${PA=
M_PWD_FILE}"
>>> =20
>>> @@ -49,3 +50,15 @@ sed -i 's/admin_space_left_action =3D=20
>>> .*/admin_space_left_action =3D SYSLOG/' $AUDIT
>>> =20
>>>  # CR2.10: Response to audit processing failures  sed -i=20
>>> 's/disk_error_action =3D .*/disk_error_action =3D SYSLOG/'=20
>>> $AUDIT_CONF_FILE
>>> +
>>> +# CR2.11: Enable Mutli Factor Authentication for Local and Remote=20
>>> +Session SSHD_AUTH_CONFIG=3D"/etc/pam.d/common-auth"
>>> +google_authenticator=3D"auth required pam_google_authenticator.so null=
ok"
>>> +if grep -c "pam_google_authenticator.so" "${SSHD_AUTH_CONFIG}";then
>>> +		sed -i '/pam_google_authenticator.so/ s/^#*/#/'  "${SSHD_AUTH_CONFIG=
}"
>>> +fi
>>> +#sed -i "0,/^auth.*/s/^auth.*/${google_authenticator}\n&/" "${SSHD_AUT=
H_CONFIG}"
>>
>> Dead code? Or forgotten to activate?
>>
>>> +echo "auth required pam_google_authenticator.so nullok" | tee -a "${SS=
HD_AUTH_CONFIG}"
>>> +# Enable PAM configuration for Remote Session sed -i=20
>>> +'s/ChallengeResponseAuthentication no/ChallengeResponseAuthentication =
yes/g' "${SSHD_CONFIG}"
>>> +echo "AuthenticationMethods keyboard-interactive" | tee -a "${SSHD_CON=
FIG}"
>>
>=20
> Jan
>=20
> --
> Siemens AG, Technology
> Competence Center Embedded Linux


--=20
Siemens AG, Technology
Competence Center Embedded Linux

