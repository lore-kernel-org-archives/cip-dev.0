Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35FBC10F1A
	for <webhook@archiver.kernel.org>; Thu,  9 May 2024 17:25:18 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.1562.1715275516237286459
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 May 2024 10:25:17 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 449HP94g2274722; Fri, 10 May 2024 02:25:09 +0900
X-Iguazu-Qid: 2yAbNsrDJsXq4JE1Pk
X-Iguazu-QSIG: v=2; s=0; t=1715275508; q=2yAbNsrDJsXq4JE1Pk; m=k/ZA//FexEy/O1/k/e/XYXwxzluJZlWfmCfCkb7xXWA=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 449HP6pQ2785598
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 02:25:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0kOs1crvAclCJM8CYBf5OsNVNAWGtS9Uzt4Cjyqlio/Kp+Ih2aXl4xzT6Z2ay9a060u9cVRx3aPRTsLHxNojvGuQevN1CTRZmBCG5PuCfkg9fn9yfTTkWjpGeMojJ+SFwsS/QMAa4vUuSopTFp/VzkpMFUtp+IKV0USoXuAKaxyM100Zd42fX8JfVRbHd6PQpSKnS9Yce7v1T9icHf+hrq+7xDQbiva+/4L+yBM1I94qcV3NtGLF3B+N9zw4j4RlFo6Nu87x0VSCK9sP+tSABox6nC46erQ4eN25y0amYAgXdsSx44luPIVewnHAIk4zoN2X+/suYfiC9Sh/cln+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsO6uT9oxBjwLhDPCrul8NYMultZdozluTc3sI4AK4M=;
 b=UUYK4EfB4NkodA+c+rKy836OZgwOWNaOhcvANb+lMNvdDf/VJ0p3WHvVs9J2t0lmAN/1AHqMVhcLXdQGteAG12xZ2CkQdvjZb9We/JLv18QCxTjkqaaMtPm1uaU3Yv3Ad4MfCNeHQHBnB44Jtb4RsNHGw7P79TrMwmxgJ4FQQaOTlA+Qd+87zcoibA2E/G3Td/A9c6mv/6XNgdHN1AwSNroSN7O/4Lc6FouIooCeYKoHr8LDJAsMY/dVUd1fPX7mcAqW2iFNFK49sX3hxHFRp+NC/XBzdbt2mEhflzLJsHbwwqaHuN3jwT45fCCsfy2uyoRjKr1igDR6YmLoIW84eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <Sietze.vanBuuren@de.bosch.com>, <cip-dev@lists.cip-project.org>,
        <dinesh.kumar@toshiba-tsip.com>
Subject: RE: Query regarding SQUAD watch job submission
Thread-Topic: Query regarding SQUAD watch job submission
Thread-Index: Adqciz/XU7pqriezQs2bbbOHPjbwrwFpC16Q
Date: Thu, 9 May 2024 17:25:02 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB61038D732173B9974298157EC2E62@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: 
 <OS0PR01MB6100BB4B8D14EC6E9527AD68C2182@OS0PR01MB6100.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS0PR01MB6100BB4B8D14EC6E9527AD68C2182@OS0PR01MB6100.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|OS0PR01MB6114:EE_
x-ms-office365-filtering-correlation-id: d088497e-ba61-4771-9dee-08dc704cf609
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?MFlSNWluL21iZmliMk9GMDVXTVZxZVRXMDF5VlU4Z2J0MWRpT0syQUVk?=
 =?iso-2022-jp?B?dmJHNFhVTnBwS0hyZG1pNVRocnM0THVKZFhMYXZJUlhCbmNlSzRLdjdZ?=
 =?iso-2022-jp?B?OUtGQ0h2OXhxRVV6QXIzM1ducEFhNUR3ajk3dHlTbUk2OTlSSCtQVlI4?=
 =?iso-2022-jp?B?RE4zcHdhZWd3ckhONDJKY0ZtTWZIak1xQThMdTNqSERlRHhMY1J6K1hR?=
 =?iso-2022-jp?B?SlpraFd4Q2U4VHZsNEx5d2hNWFZSYjgwRCt5b0VOa2EyNTBucGV4WVMv?=
 =?iso-2022-jp?B?RkVPYzkvVGRDUW9sTmpVUlErQlQ0MkdIY0Y0b2Z3ZytyR2xlc2FTQk1N?=
 =?iso-2022-jp?B?enFHTnpRazBwUGFaaDg4UUJmcWRkb3FUdVpnT2ErN0ZwN3dyM3hSRlBO?=
 =?iso-2022-jp?B?MWo4UFJ4cVVlWE94ZmZBSm5KTWdpOW92Mkdqb2d1L3BPT0F2bUwrNnJO?=
 =?iso-2022-jp?B?c2E2NzdFOGI1MGRmeVZQZjlEYjlkalNQOXJweFZpSS9DNWIrSUZvVGg0?=
 =?iso-2022-jp?B?WXQ4b0dOdVBub2E5NDlOcUdkSWRsVmFwdWl3WXVySVpjZ0Vjc3k1MzQ0?=
 =?iso-2022-jp?B?djNoVlN2MFBwOHp5SHc4WlhkYU53MHh2NWNpejRzZDFYNUU2MmRsRWQ2?=
 =?iso-2022-jp?B?Y2tWbCtQNTQyV3RJM0R3bmo3dExKUkE0bmdmYUhscUNzVnJBR2VYK0pv?=
 =?iso-2022-jp?B?cnBuNlZNR0k3MHBra25JbUZlNGoxQjhySUdZRGplSjRIYzdPMlVVU2JG?=
 =?iso-2022-jp?B?VmdISnZXSkM5NUZtVWlWbjJ2c0ZtMnU1Q0plY0lEbTI2RTh0TDZIZGFs?=
 =?iso-2022-jp?B?L1B5WHgwZWhrVVhOUHhmaVliaWxSQU5GN2FzTldSL3ZTV09hd3RKRDZi?=
 =?iso-2022-jp?B?K0JpT0JaMjFDY3hQa21CYXBIZndXQTJpdVJLMlVxNzRRZ3JUQm5BTDRP?=
 =?iso-2022-jp?B?SCt6cXkycWFiTWxSN3VmcGR4Mmt6cWQ1SkdCVVN4QmxzUmlaZFVXNVN5?=
 =?iso-2022-jp?B?bTB2ejc3MnRrMHdORXdySVY3YVM4UUJOZGVORHF2MFdHbTlGQzV5bVFD?=
 =?iso-2022-jp?B?RXl0b3krblJPdHNHVHdVeVhIbHUrUkpwVjFVTGtpWW1TelV5aEY4N2Jn?=
 =?iso-2022-jp?B?U0Zrc1lsdU15NWhBQ255cmMyK3BOcXlmTnhkN1pFU0dKb05rWE91OHA1?=
 =?iso-2022-jp?B?ZkcyTlY4SkE5M0FxVlMrR1lrMjJ4ZlhSVEJTbXMrc1ZVWVVHRjF5M2tx?=
 =?iso-2022-jp?B?dThEOFlSV2E1eC9hSUFUTTBva2RLNTlybTltVldMZEFzZ3VZSWYxVHhJ?=
 =?iso-2022-jp?B?S25YK1ljKzlOV1haYUdlb2RmYTE4WWVRUE5iaklnRU15aFRxZkV2WEMy?=
 =?iso-2022-jp?B?UkY3V0FkaTgwcHo0dFZGbDdrMVpZRXgzRk1sc3I5TGFFeWllU3AzdlR1?=
 =?iso-2022-jp?B?dWpEWjM0OVY4djlFbWRrRTZnMVF0WkozdWlkZWExZ05YS25rTUVjbXQy?=
 =?iso-2022-jp?B?K1pSNE9YYmhqRG92MHN4ZlZydHZMVm5yZEpQZElodlA4TEt3citiQVYx?=
 =?iso-2022-jp?B?TGJWQ00rZTMzc0MrS0dCRkQvTDZpdWhPY2VYSlQyZTgxaEV6b0lHWFVq?=
 =?iso-2022-jp?B?UUFMNDFNUENnc2ROK1VpQWxWSlVlQWhaZUEvbm9kOUk4K3JObHNnM3JY?=
 =?iso-2022-jp?B?TVVLdTFuRS9ZcUpxc2txQVBPUnFBSGZzcE1LRnRPcmZEdExoeEUwWHdU?=
 =?iso-2022-jp?B?TjR5VHI3Wngvd01pNHBHZ2xMM0dhVlVIYWlvc2RSVkZqdTE0Tmdka1ZY?=
 =?iso-2022-jp?B?RDV1c1FkRGR3WEQ0QnVIZWRuYVUvY1daV3BiT243a3BaZXg3Mkx2RXgw?=
 =?iso-2022-jp?B?KzErMWJ4TCt5dzJaYjhHSkxNZkNjPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?QlJEempCYzZDWkRyeGgyaGMvQy9hbW1uRWZsbEZVaWRKc1JFNktucmYr?=
 =?iso-2022-jp?B?UG85Lzd2M3p3aXlsSnBpcXVyRDB5dU9DZi9WWHhJU0xtbUsyOGhzZVFV?=
 =?iso-2022-jp?B?UnpEOENrK0JITjNyT2pxL254T2xHT2x2RlhuaGZJMHVTYWFhYzhzay9E?=
 =?iso-2022-jp?B?Ny9SeUp2bmRVeWxxRVM5WkdTaCtUcEs3MzdGK1didTRTSEwxbzVvZ2s2?=
 =?iso-2022-jp?B?a1RGMFNuTUlEK0hWZ0JiL3FvbkVLbDJsSHpOckFqOU95Y2RFNzRRYzNj?=
 =?iso-2022-jp?B?dSttUm1UVzZuYTlOS1VqRlZvTVVsdHpDNXlJVTNlMk02YXl6cTd3eFJP?=
 =?iso-2022-jp?B?RTYzMzJWZGJrWUNveXZHbVNORmR0SGVRc0JJM2QzMjRxcjV2R01kb2Rv?=
 =?iso-2022-jp?B?UDN1ZGY4UXl4ay9XVlBGdzFzVEhuK2hwdTF1NVNaaTFPOHF0OTJHcjJU?=
 =?iso-2022-jp?B?MVJGNWxHS29NOXNXQWN4dEE2ZWZpTjFscmRTWlRyMFFpdE5LSC9QMzh6?=
 =?iso-2022-jp?B?QTZBWTZPWHBaWjlIL24zb3p4Q1YrS3VFTzlPQ3JmRFBWL2k3UXN5TFFn?=
 =?iso-2022-jp?B?MXFMKzBwUFpjRnllWmhJaWk5VEo5b1g3ekQ1UklaL0hQUTJPcW9RYVBx?=
 =?iso-2022-jp?B?bkJWV2N1YmVvN3J5Y2REUkFOQjZrdFRXTzhPaFRwZ3k0bVd2MUlncm56?=
 =?iso-2022-jp?B?V0sxNnFQTEdLN0lBWityQzM3VXEvWHpQVmZEc1pkNlVBY3pQYUJDc3h6?=
 =?iso-2022-jp?B?NDhmdjdjQTZEL3BEUU5pNEVMTUhRbGttNEZiRHA3aEp2a0xWUUVSV1Q2?=
 =?iso-2022-jp?B?SVJ2dVVNYkRqSzlpNlIzWldVRXIrbkFoQXVHWFNCUHBoelVObjhvM0cw?=
 =?iso-2022-jp?B?dGtnaTVCUUc0dk1GOE5XMW1Fa0dvOEk2L3lFbFVlcEUwVFFYMGFwaEpT?=
 =?iso-2022-jp?B?YkhvNXFmRTQxOS93T1NLQVUrV3RWK0FQWmZzWTJ0TG5RZU0zaFpTWkIr?=
 =?iso-2022-jp?B?MWVlN045RXczMTViNVB6ZUlGZTdwcjVydTFHMmFLeGNIcUFQSk1UeUEx?=
 =?iso-2022-jp?B?c2k4ajlaMzlJUEttZk1GMWYxRXpWWkgyUUQyWjVVdjBZbG1wekprUGlh?=
 =?iso-2022-jp?B?eGxZcWdMUE02R3BiZmtjbStpS1NWbWE2MDhmZ2JWd1NveXFJdTVHZFhE?=
 =?iso-2022-jp?B?QUVNUlM3QTZRakRXRXJwUkwrd3VOZ2NaY0N2eHZtc0RjZWN2QVF3RGFp?=
 =?iso-2022-jp?B?NnB4RHFMM1pxa2FYZU5YNlhZK3JXVGVyaC94dHFHNUNERjIwRU0xZ01G?=
 =?iso-2022-jp?B?cWF2cDU2U1g2R2lMZUs1R3RjcDFkekVKME56VkpWNzF3TUFTTzB5ZnVY?=
 =?iso-2022-jp?B?dUx2YTBSMDJCbHVNOHFtaHpmNUUreFh6bWd5a0w5b1RrcVhGdUFNMVIx?=
 =?iso-2022-jp?B?SHRIQmZ3RkZmWGNwTDlHSXFkWkZORERTbFVGZ3NSV1VZMEZTV1BBeHI3?=
 =?iso-2022-jp?B?ZHMzUzBkdnVRR1k3VkN5Y0hONGpiUStsQlNQUUhzNzUydGczN2JsVmRj?=
 =?iso-2022-jp?B?d042N2VTNU43R2E0RHR3aTc2eTNTNWI3QS9hZ3ZpbkMvMW9taFNITnVC?=
 =?iso-2022-jp?B?ZzBvU1dHYnhZc0QyN05WR0c0UmlRMHgvcFYycVNoRHBHN2JSZllyemly?=
 =?iso-2022-jp?B?TFJ4bW5ad29WS3c0ck9sU2VjTVVsa3NFZ3NBSG1jQ1RLQWxvUnA3emla?=
 =?iso-2022-jp?B?SDZpVi91blA1Q1RFR2lFRnYzQ0NVTC9MS3IrTFVac1RCQi92ZmxJYlow?=
 =?iso-2022-jp?B?a1dwVzg1UEtsZWx1V3lHNERQU3dpTkJhRW9SZUxxQlcrNWNuWHBBWEVq?=
 =?iso-2022-jp?B?QWI2Z3A5VmpUT0lONEJUYnRtNHM3WjVTRFBLNGFmWHVsQlJVZSsrMWtX?=
 =?iso-2022-jp?B?UnpyYWtSNi9sdmdERjRsS3VxT2dHb2xoME9lSExDWlFnV3phR1lraEtm?=
 =?iso-2022-jp?B?TkFPaUw5andndWRnN2FrNWRlLzd2VWl1RnBKYTRaVTRGcXNQUWh3L3pl?=
 =?iso-2022-jp?B?bGd4VkV0RFhlMTcvbUZKTWsweHhvcm10K2NLLzZEM3laNEF6M3JmY2M0?=
 =?iso-2022-jp?B?RUszTTZCMHpkWWZTRHVrVU9YNndPY1VURXJaeEFrYURNdHN5VUZpY2do?=
 =?iso-2022-jp?B?dDJDTlFxZm14N0NRSitZcDdCQ3FLSUVRaWkrdE9xM1ZkcHVKSjA1YWhk?=
 =?iso-2022-jp?B?UjRwL2hSRE8vSHRtZmlUSTY5a1JReVBiclNmVTR3Y1JEVnk0alJhNVZo?=
 =?iso-2022-jp?B?SzdpNDNkblpReWR4N3F2ZFdpNENXdjVsekE9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB61038D732173B9974298157EC2E62OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d088497e-ba61-4771-9dee-08dc704cf609
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2024 17:25:02.7132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kRiVHphVjqHhCLVY7oU+7mE0dE1mDfzVVBQOhtNwDRwNeZ1Tq3fe0FKasBQcsmJETVJ1sNzK2T7uhsHsVZlLdwTfrKt2+qEBuE9CZFkhV6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6114
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 May 2024 17:25:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15871

--_000_OS3PR01MB61038D732173B9974298157EC2E62OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Chris,

Hope you are doing well.

The issue I mentioned in the previous mail in this thread is resolved now s=
o please ignore that query if you have not gone through yet.

As mentioned earlier we are planning to add CIP-Core LAVA test results in C=
IP SQUAD. It will be of great help to us if you provide your support in thi=
s.

Can you please create a group named =1B$B!H=1B(Blinux-cip-core=1B$B!I=1B(B,=
 three projects named =1B$B!H=1B(BSwupdate-testing=1B$B!I=1B(B, =1B$B!H=1B(=
BSecure boot testing=1B$B!I=1B(B and =1B$B!H=1B(BIEC Layer testing=1B$B!I=
=1B(B under that group ?

Currently I believe that results present under various projects in =1B$B!H=
=1B(Blinux-cip=1B$B!I=1B(B and =1B$B!H=1B(Blinux-stable-rc=1B$B!I=1B(B will=
 not be disturbed while we experiment in adding CIP Core LAVA results in th=
e projects under =1B$B!H=1B(Blinux-cip-core=1B$B!I=1B(B group. Please corre=
ct me if I am wrong about this.

We also need a user created in CIP SQUAD with a SQUAD token assigned to, so=
 that we can start modifying this script lava.sh * master * cip-playground =
/ cip-core-ci * GitLab<https://gitlab.com/cip-playground/cip-core-ci/-/blob=
/master/lava.sh?ref_type=3Dheads> to experiment on hosting CIP Core LAVA re=
sults on SQUAD.

Chris, I request you to add the mentioned items to CIP SQUAD which will hel=
p us to start this task as soon as possible.

If there are any issues with doing these changes to current CIP SQUAD, plea=
se let me know.

Note: If anyone has any concerns about the group and project names proposed=
 above, please reply to this email.

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)



From: ashrith sai(=1B$B#T#S#I#P=1B(B)
Sent: Friday, May 3, 2024 12:53 AM
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: Sietze.vanBuuren@de.bosch.com; cip-dev@lists.cip-project.org
Subject: Query regarding SQUAD watch job submission

Hi Chris,

Hope you are doing well.

We are planning to post CIP Core LAVA testing results on CIP SQUAD instance=
. So I am trying to setup a local SQUAD instance and integrate it with my l=
ocal LAVA Lab so that I can understand the traceability between changes req=
uired in https://gitlab.com/cip-playground/cip-core-ci/-/blob/master/lava.s=
h?ref_type=3Dheads and results displayed on the dashboard.

I followed the below mentioned steps:


  1.  I started the server locally after following the steps mentioned in t=
his README file squad/doc/quickstart.rst at master * Linaro/squad * GitHub<=
https://github.com/Linaro/squad/blob/master/doc/quickstart.rst> .
  2.  After the server started, I was able to access web UI at localhost:80=
00.
  3.  I followed the steps mentioned in https://github.com/Linaro/squad/blo=
b/master/doc/lava_usecase.rst#creating-a-backend-for-a-lava-instance to  cr=
eate backend for my LAVA instance.
  4.  I created a fresh token in API -> Authentication token in my local LA=
VA Lab and I added that token while creating the SQUAD backend.
  5.  I created a SQUAD token based on my SQUAD username and I referenced t=
hat token as value to Authorization token: while using SQUAD watch job API.
  6.  I added my LAVA username in the username section while creating the b=
ackend.
  7.  I created a sample group in the administration page, and I selected t=
hat group slug while creating a project in administration page.

After I gathered all these details, I modified submit_jobs script to test w=
hether I can attach a SQUAD watch job to a just-submitted LAVA job based on=
 it=1B$B!G=1B(Bs job ID.

After I submit my job to LAVA, I am immediately calling the watch job API t=
o attach a watch job to the submitted LAVA job. But I am getting the below =
mentioned error message.

$ ./local_lava.sh
/tmp/tmp.FJGGBcxzNn/IEC_amd64.yml is a valid definition
There are currently 1 "qemu" devices online.
Submitting /tmp/tmp.FJGGBcxzNn/IEC_amd64.yml to LAVA master...
Job submitted successfully as #634.
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Cur=
rent
                                 Dload  Upload   Total   Spent    Left  Spe=
ed
100   315  100    56  100   259   9333  43166 --:--:-- --:--:-- --:--:-- 52=
500
Something went wrong with SQUAD watch job submission. SQUAD returned:
{"detail": "User needs permission to submit test jobs."}
SQUAD URL: http://127.0.0.1:8000/api/submitjob/tsip_squad/cip-core-testing/=
2.0/local_env
SQUAD Backend: lavabackend.org
LAVA Job Id: 634

I am attaching my script to this email which can make it easier for you to =
point my mistakes. No issues regarding the exposed token I am using in the =
script since this is a local setup done for my understanding. Please have a=
 look at lines 17-22 and 107-137 which contain changes made to call SQUAD w=
atch job API.

I will also attach screenshots for group, project and backend page in my SQ=
UAD admin section which might be helpful to point out if I passed wrong dat=
a to SQUAD watch job API call.

Please have a look at this data and kindly provide your suggestions which c=
an help me fix this problem.

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)







--_000_OS3PR01MB61038D732173B9974298157EC2E62OS3PR01MB6103jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:202057763;
	mso-list-template-ids:528774708;}
@list l1
	{mso-list-id:1814715072;
	mso-list-type:hybrid;
	mso-list-template-ids:-1592213718 67698703 67698713 67698715 67698703 6769=
8713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2
	{mso-list-id:2135715214;
	mso-list-type:hybrid;
	mso-list-template-ids:966325784 67698689 67698691 67698693 67698689 676986=
91 67698693 67698689 67698691 67698693;}
@list l2:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:38.0pt;
	text-indent:-.25in;
	font-family:Symbol;}
@list l2:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:74.0pt;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l2:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:110.0pt;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l2:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:146.0pt;
	text-indent:-.25in;
	font-family:Symbol;}
@list l2:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:182.0pt;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l2:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:218.0pt;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l2:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:254.0pt;
	text-indent:-.25in;
	font-family:Symbol;}
@list l2:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:290.0pt;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l2:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:326.0pt;
	text-indent:-.25in;
	font-family:Wingdings;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hello Chr=
is,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hope you =
are doing well.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">The issue=
 I mentioned in the previous mail in this thread is resolved now so please =
ignore that query if you have not gone through yet.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">As mentio=
ned earlier we are planning to add CIP-Core LAVA test results in CIP SQUAD.=
 It will be of great help to us if you provide your support in this.<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Can you p=
lease create a group named =1B$B!H=1B(Blinux-cip-core=1B$B!I=1B(B, three pr=
ojects named =1B$B!H=1B(BSwupdate-testing=1B$B!I=1B(B, =1B$B!H=1B(BSecure b=
oot testing=1B$B!I=1B(B and =1B$B!H=1B(BIEC Layer testing=1B$B!I=1B(B under=
 that group ?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Currently=
 I believe that results present under various projects in =1B$B!H=1B(Blinux=
-cip=1B$B!I=1B(B and =1B$B!H=1B(Blinux-stable-rc=1B$B!I=1B(B will not be di=
sturbed while we experiment in adding CIP Core LAVA results in the projects=
 under
 =1B$B!H=1B(Blinux-cip-core=1B$B!I=1B(B group. Please correct me if I am wr=
ong about this.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">We also n=
eed a user created in CIP SQUAD with a SQUAD token assigned to, so that we =
can start modifying this script
</span><a href=3D"https://gitlab.com/cip-playground/cip-core-ci/-/blob/mast=
er/lava.sh?ref_type=3Dheads">lava.sh &middot; master &middot; cip-playgroun=
d / cip-core-ci &middot; GitLab</a> to experiment on hosting CIP Core LAVA =
results on SQUAD.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Chris, I request you to add the mentioned items to C=
IP SQUAD which will help us to start this task as soon as possible.<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">If there are any issues with doing these changes to =
current CIP SQUAD, please let me know.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><b>Note: If anyone has any concerns about the group =
and project names proposed above, please reply to this email.<o:p></o:p></b=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith Sathujoda (T S I P) <span style=3D"mso-f=
areast-language:EN-US">
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;mso-ligatures:none">From:</span></b><span style=3D"font-family:&qu=
ot;Calibri&quot;,sans-serif;mso-ligatures:none"> ashrith sai(</span><span l=
ang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligat=
ures:none">=1B$B#T#S#I#P=1B(B</span><span style=3D"font-family:&quot;Calibr=
i&quot;,sans-serif;mso-ligatures:none">)
<br>
<b>Sent:</b> Friday, May 3, 2024 12:53 AM<br>
<b>To:</b> Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;<br>
<b>Cc:</b> Sietze.vanBuuren@de.bosch.com; cip-dev@lists.cip-project.org<br>
<b>Subject:</b> Query regarding SQUAD watch job submission<o:p></o:p></span=
></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi Chris,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hope you are doing well.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We are planning to post CIP Core LAVA testing result=
s on CIP SQUAD instance. So I am trying to setup a local SQUAD instance and=
 integrate it with my local LAVA Lab so that I can understand the traceabil=
ity between changes required in
<a href=3D"https://gitlab.com/cip-playground/cip-core-ci/-/blob/master/lava=
.sh?ref_type=3Dheads">
https://gitlab.com/cip-playground/cip-core-ci/-/blob/master/lava.sh?ref_typ=
e=3Dheads</a> and results displayed on the dashboard.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I followed the below mentioned steps:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l1 level1 =
lfo3">I started the server locally after following the steps mentioned in t=
his README file
<a href=3D"https://github.com/Linaro/squad/blob/master/doc/quickstart.rst">=
squad/doc/quickstart.rst at master &middot; Linaro/squad &middot; GitHub</a=
> .<o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;=
mso-list:l1 level1 lfo3">After the server started, I was able to access web=
 UI at localhost:8000.<o:p></o:p></li><li class=3D"MsoListParagraph" style=
=3D"margin-left:0in;mso-list:l1 level1 lfo3">I followed the steps mentioned=
 in
<a href=3D"https://github.com/Linaro/squad/blob/master/doc/lava_usecase.rst=
#creating-a-backend-for-a-lava-instance">
https://github.com/Linaro/squad/blob/master/doc/lava_usecase.rst#creating-a=
-backend-for-a-lava-instance</a> to&nbsp; create backend for my LAVA instan=
ce.<o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;=
mso-list:l1 level1 lfo3">I created a fresh token in API -&gt; Authenticatio=
n token in my local LAVA Lab and I added that token while creating the SQUA=
D backend.<o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-le=
ft:0in;mso-list:l1 level1 lfo3">I created a SQUAD token based on my SQUAD u=
sername and I referenced that token as value to
<b>Authorization token: </b>while using SQUAD watch job API.<o:p></o:p></li=
><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l1 level1=
 lfo3">I added my LAVA username in the username section while creating the =
backend.<o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left=
:0in;mso-list:l1 level1 lfo3">I created a sample group in the administratio=
n page, and I selected that group slug while creating a project in administ=
ration page.<o:p></o:p></li></ol>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">After I gathered all these details, I modified submi=
t_jobs script to test whether I can attach a SQUAD watch job to a just-subm=
itted LAVA job based on it=1B$B!G=1B(Bs job ID.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">After I submit my job to LAVA, I am immediately call=
ing the watch job API to attach a watch job to the submitted LAVA job. But =
I am getting the below mentioned error message.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">$ ./local_lava.sh<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">/tmp/tmp.FJGGBcxzNn/IEC_amd64.yml is a valid definition<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">There are currently 1 &quot;qemu&quot; devices online.<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">Submitting /tmp/tmp.FJGGBcxzNn/IEC_amd64.yml to LAVA maste=
r...<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">Job submitted successfully as #634.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">&nbsp; % Total&nbsp;&nbsp;&nbsp; % Received % Xferd&nbsp; =
Average Speed&nbsp;&nbsp; Time&nbsp;&nbsp;&nbsp; Time&nbsp;&nbsp;&nbsp;&nbs=
p; Time&nbsp; Current<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Dload&nbsp; Upl=
oad&nbsp;&nbsp; Total&nbsp;&nbsp; Spent&nbsp;&nbsp;&nbsp; Left&nbsp; Speed<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">100&nbsp;&nbsp; 315&nbsp; 100&nbsp;&nbsp;&nbsp; 56&nbsp; 1=
00&nbsp;&nbsp; 259&nbsp;&nbsp; 9333&nbsp; 43166 --:--:-- --:--:-- --:--:-- =
52500<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">Something went wrong with SQUAD watch job submission. SQUA=
D returned:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">{&quot;detail&quot;: &quot;User needs permission to submit=
 test jobs.&quot;}<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">SQUAD URL:
<a href=3D"http://127.0.0.1:8000/api/submitjob/tsip_squad/cip-core-testing/=
2.0/local_env">
http://127.0.0.1:8000/api/submitjob/tsip_squad/cip-core-testing/2.0/local_e=
nv</a><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">SQUAD Backend: lavabackend.org<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Co=
urier New&quot;">LAVA Job Id: 634</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am attaching my script to this email which can mak=
e it easier for you to point my mistakes. No issues regarding the exposed t=
oken I am using in the script since this is a local setup done for my under=
standing. Please have a look at lines
<b>17-22 </b>and <b>107-137 </b>which contain changes made to call SQUAD wa=
tch job API.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I will also attach screenshots for group, project an=
d backend page in my SQUAD admin section which might be helpful to point ou=
t if I passed wrong data to SQUAD watch job API call.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please have a look at this data and kindly provide y=
our suggestions which can help me fix this problem.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith Sathujoda (T S I P)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_OS3PR01MB61038D732173B9974298157EC2E62OS3PR01MB6103jpnp_--


