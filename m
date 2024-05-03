Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C6CC4345F
	for <webhook@archiver.kernel.org>; Fri,  3 May 2024 04:31:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.5223.1714710711773854754
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 May 2024 21:31:52 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 4434VjnL740832; Fri, 3 May 2024 13:31:45 +0900
X-Iguazu-Qid: 2yAbfjWaknhOVZ6tph
X-Iguazu-QSIG: v=2; s=0; t=1714710704; q=2yAbfjWaknhOVZ6tph; m=Qfv8edoXhzFN86VmYxjdfiovLJeDwq6BUwH/lcjUa7w=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 4434VhMm895297
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 3 May 2024 13:31:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=On2ZgtxfD1i+MnxbUKCd0Axx0C1KJJ1UpUDLn05C9afL2UDKlSMEoKSbiCEp3UJyMA02HYaYLLFg/LZjY1KTXcv2CKRL3UVBmZN++eKjF16T/u2ZYOE1HY+1o8Pqv5KHHbbNZXAPOtaBIKQTLcgxHVBFGnlmq1n9TfsZOkVYk0gA2D3tjfN7a6JwGvJL7JafuwEuKrc1nYxmvTKMsCAMUYvYLscLwKTxLZUmCEKTC0BxuvuCedpANntfwQYb7ff3UmVSGExC2YR+MlOyZ3nD4IE1hETb/BzMUjMQMIskntdxZ2E7nPNNDq912Q1PgFFyyxbFK90S81tugKyLcLvpOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVb5pSVSLKLtWraMbDS3ecHipEu3lSFyo6lDKIqQ6W4=;
 b=WV3qR/vG1i6kCLYtepjkEt5P1VSWTVRApKNTXF2QV7XIe9lh7hv1Vc5G99BApHa8yveg8260cqyVg25KYFfBjmQhumbdcBGQcImVe0/kxWuNINtZw04MLRTA5cwLVldY4B+MUuGJZgc1/6eHk1ZKhxfEPUOJEI//h8vboltbxY7JwqWRzO73jztJy63OzptHws8bRwou+fffTkrp71Cp20xjJBi/cdIgm47oQhw4XXE0YuckweC7v/8XLwMVa2jJflABo+/7bVZ7UiMt2hwYnGrdDsuW4rNqmEehVZicwC6F/yoQZBJzyEkf6rXa8APUQZGLMEvdCTnb/TqdbGzmng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <Sietze.vanBuuren@de.bosch.com>, <cip-dev@lists.cip-project.org>
Subject: RE: Query regarding SQUAD watch job submission
Thread-Topic: Query regarding SQUAD watch job submission
Thread-Index: Adqciz/XU7pqriezQs2bbbOHPjbwrwAhgrSA
Date: Fri, 3 May 2024 04:31:41 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB61037CD9DE8F85E63A9EC0DEC21F2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
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
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|OS3PR01MB10025:EE_
x-ms-office365-filtering-correlation-id: 21150572-7ba5-4e23-9495-08dc6b29ee30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?UDdyNmJEekxYOFpZTDBtRk85d3h2aDhnbjVRODVUTm0zZGVMZ2g3NDNN?=
 =?iso-2022-jp?B?VmtpSVhiVno4N3hSeVhYa09VK3NvNDlJUmJwL3JVTjhTRVVVOUZuWWlh?=
 =?iso-2022-jp?B?RGJRNUY4OGdIWkNCcnRXd2s0SEZ3NjhmREo3QmZTMG1ZYkVOeTVzZWUx?=
 =?iso-2022-jp?B?WlMxQmQyR2NtNzRGSkxwdmhOSUx1dFdoNUpYK2tOb0pCeGYzVVdXMFpO?=
 =?iso-2022-jp?B?dWdWeFpzM2FUeTU5RXVEbnQyZ2JwS2h4YW9JZG5ZdTVMRmRiZUlVazZr?=
 =?iso-2022-jp?B?aCs3cDkvcEt1ejZYWGppc0ZUVFJVZjFOeWV1L2JrSy81UFhDR05nY1gx?=
 =?iso-2022-jp?B?RERjZEszaEJtMFhTdXlqRVJIUmVuZFRXUkh6bVdNUlNsRjNUUVdWSUxj?=
 =?iso-2022-jp?B?b05KRW5QTDB2UVc0WS9KVEZzeUtKTUlQTDRyOXRBbHh4RURWNnhsbDlD?=
 =?iso-2022-jp?B?U0NXc3lORkFiM2g0RkdmUkZiYk9TNWxwM1JwVksyMWVGRkYzTUNNRWxO?=
 =?iso-2022-jp?B?bzJFbk42T0Urbll2THAzRE54V1BCMG9kL1FrdG1UMGFleTBDY1V5TnBh?=
 =?iso-2022-jp?B?b21SeU9mMDc2bURBdXdZa1dSSTRQSFdjV3RHMDhTZzZKZitHMjZDV1Nr?=
 =?iso-2022-jp?B?aWxkSTg0bEJ5cTYwVmV1L3Rrc2pqY1JWWkZDcWxnZEVHbDd3U1hmS1lo?=
 =?iso-2022-jp?B?MHc2akZVdW5mekpLdzFlNllZTjRiQVBWZTd3VHBMVVMrWnk2czBxRUli?=
 =?iso-2022-jp?B?MHQ1VGtCMGd1bWNEOHh6MXgvdTA0c0RnZWRuMG5ZTy9hVUFpS3krTXd3?=
 =?iso-2022-jp?B?dzVUeXV0WUJ2Q3dVREZMRE9vN0VoODArVTlnSy9Xemt6OUNabUJDbTg4?=
 =?iso-2022-jp?B?T3lwTFBHMTdPeFVuMUg1MUlYazdCSkoyOUtQSmk1NVJidzVjR3Y0b2E3?=
 =?iso-2022-jp?B?R25HU1FrTUFFWlVpelF0MUtBbkpFbW1MVmhXN2J4dlZ3TnVSb3JBQWpo?=
 =?iso-2022-jp?B?YWcvbG9LZDRoSVdlQlQ0eXlkOFBlQ2MrWUo4Q2lkRWNtaFltNzJJUFNP?=
 =?iso-2022-jp?B?WlFZbkVjVGR1NGF5cUR4bFJKTGF5OTlyQnRyWGZHVDQya0pSQk9MLzBX?=
 =?iso-2022-jp?B?T0FJcXIxNklTNlp1OFMxTUZGRUtPSVIxay9xejcxM2taRTdOdUtRK2Rk?=
 =?iso-2022-jp?B?c0M4RFZYSC9pbThPRVpwUjZoL2Z3NlVacTlMa2wwNEJtY1JnZVdPZWJF?=
 =?iso-2022-jp?B?d2l3Y2F2Rzg5Vm9TUEkvNmJYamIwM04yVzgzTVVhL0kzSWtjRnlDN0lh?=
 =?iso-2022-jp?B?OW5rcDdJK2xwSXR1djBPVHdwTGwreHowd1M4QXI5ZStPeFljdk1HWWxp?=
 =?iso-2022-jp?B?RFdhc1hlMU9CYk1lWDM2eFJZNm5tRmx6enkzaldiMkdwWFZja3lpTytk?=
 =?iso-2022-jp?B?QUpOanRpdC91WWJYZDUyTXJaUmFLaUZnZHc3UE93amNSbUFrQ3ZobERP?=
 =?iso-2022-jp?B?UFd5MVJvek5pRmhBNmhFb0xOWG4rWm5wT1g5OVBuc1VtM3pUUTNNSlFp?=
 =?iso-2022-jp?B?TFkvZXhZUmZOdDZITlhjd0ZRb1dCMjRmY25TRWtyTFVtWUJBNmNpRi9P?=
 =?iso-2022-jp?B?THRlQUJ5dm15WFprV0FoSElpb3N4d1FoVTVjeFJwM0JZb0xLR2h5bGVy?=
 =?iso-2022-jp?B?MXFWTkEvbXUxWFQ1VTRyRElVaTJjM3VWV3B3b3UyeXZnS21kS0lUQXdx?=
 =?iso-2022-jp?B?VUZNSzB1U0RvSnBRd3FPbHJGaFg4dGtTUjdBVWlMMzNxU2ZKbXBGeitF?=
 =?iso-2022-jp?B?ZFhORnh1VHprUnE5WWM0am0vVlJ0THRBcjM1N0VFNUNxR0szRXNjY0ZB?=
 =?iso-2022-jp?B?PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bUkzd0k2Zkl6RXBNU3YzZTdMZmpiSkxOcGcyQ0xWMFQweEdWbGpvdFZF?=
 =?iso-2022-jp?B?d2lqZUE2eWpsMlpLMEpQNXpqbjlZWllxUFZpd3pHdmpiMHRqZU1pRGJE?=
 =?iso-2022-jp?B?bU1EZEtJamZ4WU9RaGgyZjd2N2d0d2JnSmdlcXRxNjBDMDBKK0hWUnNE?=
 =?iso-2022-jp?B?SkExSTM4enVyNXlTZ01MejNhSUt0ekJ0cUJTMTQ4MDNWamZCZnZxS1JV?=
 =?iso-2022-jp?B?UjlwR0FRQThxTWppL0h5M0FyYnA0REJMc2c0dTcxb0pnUHFmQXZpMVc0?=
 =?iso-2022-jp?B?WTFGTmVFZnpwWGRjeWVjODlQL0diR3B1dWRMcVZCSTNueTNZMVRyS2N5?=
 =?iso-2022-jp?B?WnZzTUZRS0JDNWlNU2g3dVdBNHpHbDZEZUdwUWZFbDZvanVNb2hMN0cv?=
 =?iso-2022-jp?B?aWM1MDRyWTRxaW8vWjkxT2RrY1hWam9GQnhkcFdTQkRQTUFvRzFsblUr?=
 =?iso-2022-jp?B?VnBGVkt0VFpIaDUxTjhOcmVTNnlRUUE5ZkNsOVpxQWlnZUN5ZVpTbzdD?=
 =?iso-2022-jp?B?Zk52Y3kvckd4NnpsYVl1ZFd2T2dIVVU1ZXFBU2xRT0U1WE5PTmUwcm96?=
 =?iso-2022-jp?B?MUhzSjdiOGdJaTF4bUhsaDdvR1ZlMTlBazFubmNsUzg2bGlOa0VmSUlD?=
 =?iso-2022-jp?B?NDJscWZ0VXcxWUxHWDd0eGJ2NEhoYVRvWk8yZW1KUmNpMUQvRWd3L2d6?=
 =?iso-2022-jp?B?dHdXQWdmbzRvNzUxL3lhdzlUczVCalRQZ1V3YXBCT2YzWS80VXhITk5m?=
 =?iso-2022-jp?B?Z1IwdkY5N3BBMjV6c3QwckhGVkJoakxObHpzSjA3c1VBOTdGNFN6cnJk?=
 =?iso-2022-jp?B?eGZTcG5QL2ZxNEhHUVREd1V4c0NudzdiTnpHWXFDTnpaQWU5RGRkNXBw?=
 =?iso-2022-jp?B?bERieXhrSXJjL1o1bElNN1F1d1BnY24yWC91Y2l0eDRWdmNyYXhsMmp1?=
 =?iso-2022-jp?B?aGsydWxOaERmOGMzZXkzSVZUQjhLSzd4YlNQR3VRZjN5dE8wOUJuV2RB?=
 =?iso-2022-jp?B?QXlYbnUwUWlDM3A1OGpBSGdaM1RwUjdMSm9HL0pQTzVCdXlxSlUrTWZl?=
 =?iso-2022-jp?B?aWREdzZDZHZEWTlKZFRvU1p4TzFMcHE0aFQyOFFsVmdlWHRTRG9KZXQ3?=
 =?iso-2022-jp?B?NnQ0S2I3dlBEY251SWJkRzRMc3lRcllTMDVJeS8yU3NTWXkxb0lVeEoz?=
 =?iso-2022-jp?B?ZXJwR0ZrSUxrL2Z5dTNWNjlpNXVmRzFpbGQvd3VjcWJ3WlpoVXI2Z0lh?=
 =?iso-2022-jp?B?ajgwOEtjbFdYOHVVQVBLM2RqN3E2YitHbzkxYlVHT1ZwK1JQVGM3eFEv?=
 =?iso-2022-jp?B?ZmQ3Rkl1bUQybnl4Lytjb01VMWNSQ3RzVUNVNWFhdHdZZTQ1ZmRuZVM0?=
 =?iso-2022-jp?B?bHZ6cnhWVFdMUnNqQ0hIR0owbU9BYXNORnM1RWdSOEhlcDlvVFlvS0J5?=
 =?iso-2022-jp?B?bkhLMFozQjcwaCtzSlBtbzJKWVkrNXFVa2lqSTdYNkNOc2VidmsxR0Rr?=
 =?iso-2022-jp?B?T2k5Q2UzaTZvNEZzeFFlSzlVZFY0ODVDUXN4cWRyN3kxdnFJMWxNKys2?=
 =?iso-2022-jp?B?bkVOVi82a1NEUXczWFdES0s4U0I0OGxzMkFVOWhGNWtsMy9CV2xWZTJm?=
 =?iso-2022-jp?B?VVMyQy84dDRUWG55cGhpenQ5S0J6U0tGdEVWUGtwb2RLL0J2S2pqaGoy?=
 =?iso-2022-jp?B?QVBsbUx1NFhmRkMyU0NxZkZmblk2TkFxQm9IeFRWaUFLY0xMbUNKT1Z1?=
 =?iso-2022-jp?B?OWFibUU3WGR1UUh5cUJrMEhjN3RtZVFnclR0RU02emJSTW1IT3BURCto?=
 =?iso-2022-jp?B?UkdNeExFNnVGNUpSTkc4eFhWMCtxbVdaWnZtajN1OWVweUYxRWZZNGpy?=
 =?iso-2022-jp?B?dm4zd1dXTFR5cnhzUXVkRTB2dmc2MDJpbDNBMjRKbWJiNWVYRDVDN3gr?=
 =?iso-2022-jp?B?WHVxUjhJdWQvaCtmNEdrSjMvY1BGTEs2c2tJMHhmeGdpSTg5elNldUI1?=
 =?iso-2022-jp?B?SVBaZHhpZi83ZUxNbVBSbituNDNOeDRYbjRsVURGWmppUjFvWlpSNjY4?=
 =?iso-2022-jp?B?QnFka2hmdGg0cG5tOVB5Q0UzZTNDT3RxZ2hTRVNwT0lXaGp2cnVkWVky?=
 =?iso-2022-jp?B?UHF0a3BvNlYvcTRwQ3JEWjVQV0RKVzZLVWtPVTZmMFI5RlE3Yys4NGhW?=
 =?iso-2022-jp?B?MXlVLytwWkh4bVZGZHFoZFRCNENNSXVET0dKZk9pR0I1bzh6WHRiQm8w?=
 =?iso-2022-jp?B?eCs3WTkwZm1QTUVZVTZxczJZTmx3Vm1EeEVnK0Q0cExDaXNDdmMvb1Bo?=
 =?iso-2022-jp?B?Rkl1UzBkZU9qbmpzNm9qcjFPY1lQdG8rS25VZDY5M0pETS9PWlU5aHha?=
 =?iso-2022-jp?B?My8yOFZNN0VDWnVaWFFycnVEYitTNU9waXdaV29tTU1ZdzQrSzVYVFJm?=
 =?iso-2022-jp?B?b1RoRFFnPT0=?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB61037CD9DE8F85E63A9EC0DEC21F2OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21150572-7ba5-4e23-9495-08dc6b29ee30
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2024 04:31:41.3680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w+P9+qyfBh7r+GOoDy2DewE99z6TO0ebOIw9v8+I+FMITlspw8JZeJ1l5gcOL4KA1DSGI26/W83239tQo9yOTNH0hTzTNjIyuEbADLsCAtc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10025
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 May 2024 04:31:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15810

--_000_OS3PR01MB61037CD9DE8F85E63A9EC0DEC21F2OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

I just wanted to clarify that the local_lava.sh which you can see in the co=
nsole output section is exactly same as submit_jobs script I attached to th=
e previous mail. Sorry for the naming confusion.

Thanks and regards,
Sai Ashrith Sathujoda

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







--_000_OS3PR01MB61037CD9DE8F85E63A9EC0DEC21F2OS3PR01MB6103jpnp_
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
	{mso-list-id:1814715072;
	mso-list-type:hybrid;
	mso-list-template-ids:-1592213718 67698703 67698713 67698715 67698703 6769=
8713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1
	{mso-list-id:1912887948;
	mso-list-template-ids:311692384;}
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
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hi Chris,=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">I just wa=
nted to clarify that the local_lava.sh which you can see in the console out=
put section is exactly same as submit_jobs script I attached to the previou=
s mail. Sorry for the naming confusion.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Thanks an=
d regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Sai Ashri=
th Sathujoda<o:p></o:p></span></p>
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
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo3">I started the server locally after following the steps mentioned in t=
his README file
<a href=3D"https://github.com/Linaro/squad/blob/master/doc/quickstart.rst">=
squad/doc/quickstart.rst at master &middot; Linaro/squad &middot; GitHub</a=
> .<o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;=
mso-list:l0 level1 lfo3">After the server started, I was able to access web=
 UI at localhost:8000.<o:p></o:p></li><li class=3D"MsoListParagraph" style=
=3D"margin-left:0in;mso-list:l0 level1 lfo3">I followed the steps mentioned=
 in
<a href=3D"https://github.com/Linaro/squad/blob/master/doc/lava_usecase.rst=
#creating-a-backend-for-a-lava-instance">
https://github.com/Linaro/squad/blob/master/doc/lava_usecase.rst#creating-a=
-backend-for-a-lava-instance</a> to&nbsp; create backend for my LAVA instan=
ce.<o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;=
mso-list:l0 level1 lfo3">I created a fresh token in API -&gt; Authenticatio=
n token in my local LAVA Lab and I added that token while creating the SQUA=
D backend.<o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-le=
ft:0in;mso-list:l0 level1 lfo3">I created a SQUAD token based on my SQUAD u=
sername and I referenced that token as value to
<b>Authorization token: </b>while using SQUAD watch job API.<o:p></o:p></li=
><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1=
 lfo3">I added my LAVA username in the username section while creating the =
backend.<o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left=
:0in;mso-list:l0 level1 lfo3">I created a sample group in the administratio=
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

--_000_OS3PR01MB61037CD9DE8F85E63A9EC0DEC21F2OS3PR01MB6103jpnp_--


