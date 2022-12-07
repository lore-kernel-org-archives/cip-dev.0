Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24267C63706
	for <webhook@archiver.kernel.org>; Wed,  7 Dec 2022 08:30:30 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.10509.1670401827300919814
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Dec 2022 00:30:27 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.153, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 2B78UONr013023; Wed, 7 Dec 2022 17:30:24 +0900
X-Iguazu-Qid: 34trJAtFEiwLIvHAeY
X-Iguazu-QSIG: v=2; s=0; t=1670401824; q=34trJAtFEiwLIvHAeY; m=uATnSaUMrOa9wBwwGGUO5vyVeHbaDbE8IlGAd+JVQoM=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1512) id 2B78UMDl036152
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 7 Dec 2022 17:30:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiwymygxIj1WubabgMcA0ykf3l8bhSS7tPD8DmS/b+0ZgTdF1SIdl4ybYXTrP2CwwyrHI53kqWfqMUWxuwO0BJvDchoJo6JaiMF1QrbuOYthp7x2llGNAo8dlSJEFeRRh0m/bILqAwdzHbHLIh0XUHb5PdCYFMnl0XQcUsJGiy0ISny+jHVea7xp2WUUk2CHjbzDgsdaaGmcc3HIyG2Z31/M8kQMBikESXclWiJ0/8GPN7+ZLASRuxDn7/N8bJSm/EAB0XnSbTOZGhZbwEz6uon/XKP6GE6NyqH7yKABVcz792ymQd6IFb/zyB53RuWaXBW2UzYJKwkWeE+TXDpanw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScrNUMjl/2SJ0X99pjW0dgf1YUg8grn/iLZizQm8cRA=;
 b=BJKhfB/uEpvXy9kFnfIEFj4n+01XmwPxq1ZidUMKNyYFiNB0JF15vEQdkdUtZdF++grXX1HHxQYa+wH+i0mcySdY3qeek3cYmBiZSLT2Cz8lh5qdQop1e4JSpYedykY8NuPr6dm1kmsMpAvZuHaFTTovJgsRzZeOi+EqId3ybgtBF1u2h5otkNCAGYGA5CJ/qtMludqPLKgOMZ+el3j9pK9YfEqCSMfJWu3DRy1H+54k3OAwcQ6CSPHIpNwDxaG3/LXfLlJ9OAsoW9rawEWaC/2YyOIGB1piHN9MUre3ONJXCzQsrz4zytE2GNrskyUFmDKQHSDN9/EL7PglDUz8nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Sai.Sathujoda@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>,
        <jan.kiszka@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [isar-cip-core] security-customizations: Fix account locked for
 non-consecutive failed attempts
Thread-Topic: [isar-cip-core] security-customizations: Fix account locked for
 non-consecutive failed attempts
Thread-Index: AQHZAunMi6CeNZRyfEO7l7WrnqmFQ65iE5kA
Date: Wed, 7 Dec 2022 08:30:08 +0000
X-TSB-HOP2: ON
Message-ID: <OSAPR01MB494572F3C47780AECC7AA35DC21A9@OSAPR01MB4945.jpnprd01.prod.outlook.com>
References: <20221128052502.19286-1-Sai.Sathujoda@toshiba-tsip.com>
In-Reply-To: <20221128052502.19286-1-Sai.Sathujoda@toshiba-tsip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB4945:EE_|TYAPR01MB6220:EE_
x-ms-office365-filtering-correlation-id: 323130f7-6a34-4fc3-3814-08dad82d403b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HV8IEm0Al7xVBwNZ+gFd7c84FV8DixGm9i172RIrx6aIgo0giSBsJXue8feczmCD6xSYCeYLfEzkwf9syyCvc71cZD7C8S9fun7b69XHdTAgdxfinBraL/YWH2Vyeo/9tu9/Zmymn29h4O5Hfmxp1dwhJueGi0aAjt8wY8ox1Db23wJecvDURlOGv6nnWltTT5jMf9ploSqfPgyn87WRCEpOHR0izBqsSeiqecOWZfDQc42pyfVeDo0wz7pDnzeu3uMPFL7rV2XBSUJ0aiWTs95UIs3EeTQhZFme9twN+fdUd/J5aD8x7qPuUn3nbrn89t0skbo5EC0JYLCnhR5T801l8mMmf6DBi1SP5X+qRaWRBU2eTmWggcbBx2kE4boJLsqWWLN5vAajaKStbbdnjMtWoXGODgZGsfF0jw/UXtckmp6z5hvVUHBk6UI2UDrgrevQKRY/qnTvbNh7sJC67SMfkdTosTLhacQsmr/DoRNeOXZkUdjNBX9U4JspzV09t4X5ywc+8/+kf1+ANKaFLfSR82/GCo3PGBC1lq1BzT+4WFnPgu/vltxsn5nu6vHKfi1u4yLvXfu0qTlohR+WMlKWwOS7zzHEsCYksMeF1rZWHfnLUPMtfK50mnHBZ2+GLC7AhXKiHpP1gkTUqi3GvrvJ4w9V9noQLowPUAIFSB5xoF+6LvO3VrnvqVlDjYIoQ0W6K5vdmjz3czBWsPhsQGfWuk+6IpRe6CnylyovaYw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB4945.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(451199015)(38070700005)(38100700002)(55016003)(86362001)(966005)(6506007)(7696005)(33656002)(85182001)(53546011)(478600001)(71200400001)(4326008)(107886003)(8936002)(26005)(52536014)(76116006)(41300700001)(9686003)(5660300002)(64756008)(66946007)(8676002)(66446008)(2906002)(110136005)(66476007)(54906003)(316002)(15650500001)(66556008)(83380400001)(186003)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?SHk0SEIzNTBrdTg3a09kT21wRzFrd3lLeHVPbDFrc29sdm5CcVljUmJB?=
 =?iso-2022-jp?B?TFBUTmFRa3Axdkl2Vi8xa0ZjaXZ1WmFOMkE1WVAvUC80Snk2bzN0VmN1?=
 =?iso-2022-jp?B?bGdIV1l1OG51Q2ZTc0hVT01yYnVURURJRnRMT2dsc1lMZzVTRmU2OS9r?=
 =?iso-2022-jp?B?aHVzaWFibDZITE9xTU40YTNhTFNuZjRnTDBsNmV1SjhZRDNEbjFlQlhW?=
 =?iso-2022-jp?B?eStlSWNtN2t4by96L2xqeERtQXJZV0h0U09kSkliUHk3MDBidzRFcEZq?=
 =?iso-2022-jp?B?RGRvL3pOREtSTFJoMGJ0dlVCZE1NUnNBc3M2cGk0M1N4NXNyNU1iaWtj?=
 =?iso-2022-jp?B?cDNVMWRuL29KQ2x3N3MvcjRSdlFxZTZLSkVmckxrTXduckxHek5ianpH?=
 =?iso-2022-jp?B?UzNkNmlVUU51MjhWVU85SjA0SURwdUFDd1JORGZ1UTNzWWs0VGs3Smcz?=
 =?iso-2022-jp?B?dmFZL3lyUjd3bWh1dDkyQ2J5a2NFUEtvRk8zZXpEMzVPOWhSMkh5dHpw?=
 =?iso-2022-jp?B?NjhxNllUa2JiYkUzZXVGZFNlcmJEYW8rQVBFRSsrMlE3WWw3a3NpUnRX?=
 =?iso-2022-jp?B?SkJscVhGUGxjNGJiR3B6ams4UmpEZjBzQUZtTDBDb2JmMDAyS0VNTVRk?=
 =?iso-2022-jp?B?NkxVb2RWTENWRkFxNlE0ZlpObXM1bFZwZTI5RDJXaHFXeDVsTDRzSGNq?=
 =?iso-2022-jp?B?RW5OMCs1VXVjYWh0SjBvV1IrVkxnZnpCdlZXTStDNlljUzh6MmVOb3kz?=
 =?iso-2022-jp?B?TDFuYUhZWHZQdTFudnhYN0tHUEE3MTJBQzQvM3BNMVpoWFJ3SWlMZzlW?=
 =?iso-2022-jp?B?Y2ZJY2p4OCtLaFVQbkN0Q0NTd0JXVWZpQU84T1NjaldSQjVvT3U3dnJU?=
 =?iso-2022-jp?B?UE1laTh6c1pXM1VTTVVlMFBvTXRUQ0lML3l2QWwxR05jUFZBRy9NRWNr?=
 =?iso-2022-jp?B?T2dvVnhmK1RrNkxLMVFCdmxBQmVPYytiSkRWaVFpOGIvZ3ljTnVxWnNR?=
 =?iso-2022-jp?B?eDRETStMdnMzZlRBUm0yczJ1Uk1LT0N6VGlKSWc5ZjVqSm5GeUlzYUxr?=
 =?iso-2022-jp?B?TkpRMW56elZWZ2FBdGpxZnV4SEhMNFdQY3pFd1UvSUx6QkFENU1mL3Zk?=
 =?iso-2022-jp?B?UWZhZGNvcWdBQkkydG1sOUx6TWJweVhwV3Q2YWpjRDh6dGtyY3NPQzQz?=
 =?iso-2022-jp?B?aTJaS2lZMUlEaXpJZlcybnpnSmkyUDE1TWU4aHcyRnE0TjV2WWhXN0Nt?=
 =?iso-2022-jp?B?aUxPMGZVS1NiYm1uMDRMaThuc1VoYTZKZFB2d3BRaVhIY0tvcFdNVlox?=
 =?iso-2022-jp?B?Z1BaTU4xYmlJMjc1Uk1NVVh0SXRXTDlUZ0JDYld2RU9HaERmN3hFcFF3?=
 =?iso-2022-jp?B?YXhWNE5yQmhJbDlJT0krSmc0RlZsMmM4UDhwTGZOU1lBdUlQaGZOdnNS?=
 =?iso-2022-jp?B?RUJNQkdvVnBPZEQyN2hQYjBHNTRoYU83ODkrYzM2Ym5sTmIwV2xjN3Zm?=
 =?iso-2022-jp?B?SkZrZlU4WmtibWYveXl6ajdSejZ1Mm8wazVaUzdTRm5sbkt0N2VVMmhD?=
 =?iso-2022-jp?B?ZGVPYTNUWkYxbFpJMFN1eGdNNkFLdy8yb1RzY25iU1AzUENocGpOZGhE?=
 =?iso-2022-jp?B?ei9jZk54SkF4Y1Y0M29YRDJmSGVod1ZsN2NmcjFQV3FNaFB6TksrZFhI?=
 =?iso-2022-jp?B?UWQwZHBKVnp2M2tQSGNEeHlHVDM4Nm5uTGpCNWZnd2ZLSVJoeStZVWxN?=
 =?iso-2022-jp?B?VUxSQkppNndpcG1ualZYTnJHTy9US1BRWTR0ZWtaZEluM3k0Uzc3YVF5?=
 =?iso-2022-jp?B?NnAvZStPd0ZvcG01QVBtV2dDR2s0N2RXaHZHbEdmejJJN2VxYm9hc1RT?=
 =?iso-2022-jp?B?aTNhUGRKN0NYRlZ4QU9vU3JFbXoyQUVZZVlhMS80dFFmMjFTcmZYL3pH?=
 =?iso-2022-jp?B?R2RUY0lFTFZEUFY2QWhXQUF4cVppWWMycGxKTEh1bzVFaUJld2FZK1RG?=
 =?iso-2022-jp?B?UzZWVFlFd1NBNFppT200ZEQwcEliRnpPTU9FV090TUc5NVNLZExyYVJs?=
 =?iso-2022-jp?B?SlczZkZyQXB4T29EaVBtMGMxSVgxSTFjaHdpTTJGcmpoU2lmMVp5a2F0?=
 =?iso-2022-jp?B?SW0vR0hLMlNuZ1lkTFhTeGVPTHNQelBGN211cEFIL1p5c0JQcFRrSkcw?=
 =?iso-2022-jp?B?ZGowTEc4U3dka2hCRS9wdjVIZ0pkVHE1VmJMMWs4cGh2d2hGcWt2Y3Uv?=
 =?iso-2022-jp?B?TDFiNytRVG05TEkwMmNNT0ZuTUdOZkhlMmN2YnNaNE1XcGtJZmhrYVNS?=
 =?iso-2022-jp?B?OHZBWEVlZWJPVjFoU3V0TXlsKzNURGRlaHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4945.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 323130f7-6a34-4fc3-3814-08dad82d403b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 08:30:08.8472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: joX99wauQapjxNlRlfb49v/rzfEfTpyx/8FEyikU+KwiTH3COHl8YeY5DvvXHvFYACby7xqBajnj/eZNrgSJakq5y/qhIbm0Uh7Z8LdnQfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6220
X-OriginatorOrg: toshiba-tsip.com
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Dec 2022 08:30:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10161

Hi Jan,

Can you please review this patch ?

Regards,
Sai Ashrith (T S I P)

-----Original Message-----
From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>=20
Sent: Monday, November 28, 2022 10:55 AM
To: cip-dev@lists.cip-project.org; jan.kiszka@siemens.com
Cc: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>; dines=
h kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.co=
m>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B""#S#W#C"~#A#C#T=1B(B=
) <kazuhiro3.hayashi@toshiba.co.jp>
Subject: [isar-cip-core] security-customizations: Fix account locked for no=
n-consecutive failed attempts

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

As per security configuration the user account should be locked for consecu=
tive failed login attempts, but with current pam configuration it is locked=
 even for non-consecutive failed login attempts, because it is missing the =
pam configuration in account phase which will do necessary reset for non-co=
nsecutive failed attempts.

Closes [1]
[1] https://gitlab.com/cip-project/cip-testing/cip-security-tests/-/issues/=
3

Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
---
 recipes-core/security-customizations/files/postinst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/recipes-core/security-customizations/files/postinst b/recipes-=
core/security-customizations/files/postinst
index 0d0eb07..4ff8ecf 100644
--- a/recipes-core/security-customizations/files/postinst
+++ b/recipes-core/security-customizations/files/postinst
@@ -25,11 +25,13 @@ PAM_AUTH_FILE=3D"/etc/pam.d/common-auth"
 # pam_tally2 is deprecated from pam version 1.4.0-7  if [ -f /lib/*-linux-=
gnu*/security/pam_tally2.so ]; then
        PAM_MODULE=3D"pam_tally2.so"
-       PAM_CONFIG=3D"auth   required  pam_tally2.so  deny=3D3 even_deny_ro=
ot unlock_time=3D60 root_unlock_time=3D60"
+       PAM_CONFIG=3D"auth   required  pam_tally2.so  deny=3D3 even_deny_ro=
ot unlock_time=3D60 root_unlock_time=3D60
+                 \naccount required pam_tally2.so"
 elif [ -f /lib/*-linux-gnu*/security/pam_faillock.so ]; then
        PAM_MODULE=3D"pam_faillock.so"
        PAM_CONFIG=3D"auth   required  pam_faillock.so preauth silent  deny=
=3D3 even_deny_root unlock_time=3D60 root_unlock_time=3D60 \
-               \nauth   required  pam_faillock.so .so authfail deny=3D3 ev=
en_deny_root unlock_time=3D60 root_unlock_time=3D60"
+               \nauth   required  pam_faillock.so .so authfail deny=3D3 ev=
en_deny_root unlock_time=3D60 root_unlock_time=3D60 \
+               \naccount required pam_faillock.so"
 else
        echo "No suitable pam module found to lock failed login attempts"
        exit 1
--
2.20.1



