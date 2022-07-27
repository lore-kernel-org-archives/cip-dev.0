Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10621C19F29
	for <webhook@archiver.kernel.org>; Wed, 27 Jul 2022 07:56:29 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.17393.1658908578921390245
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Jul 2022 00:56:19 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.153, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 26R7uG0S002035;
 Wed, 27 Jul 2022 16:56:16 +0900
X-Iguazu-Qid: 34trVoG0dZJNOCgT3Z
X-Iguazu-QSIG: v=2; s=0; t=1658908576; q=34trVoG0dZJNOCgT3Z;
 m=oRSBd/t7TN3pPGcm+bvLGncMcO9tOx3IRQ5J7TQ7eqw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1510) id 26R7uFWl012941
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 27 Jul 2022 16:56:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b05Uq+o1hbjkkikN0flQat9RoEvrJLRUpZ3bqcFc0h8fc4WWO2qkVFwh2X/JodOI0lJHbdEFTB3t8OZGEQmcYonagLqs0y7lCmxT2SPjlhBL1bLjp00GZU4SSSe7qR4BsPUxGYuBsOVbvxzcWnK1BKdEYD/f9reKDlBzBdntKhdIstrl4wQr3Hdbao7IiMfsnQhz01gFzGXTKu+g7ZoIxflXoS+8Lq3CafTGojRssyHmD5yyJICTz2htIxUoyv9P808w30cIVKMrDA50Y+759qf9iE5OMnV1GPncg2B09UpIvhzdxdaGAdSc2di7lqEmyTjeT5lfebaW7zmH/tyrnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xS9sGtRuJnfOK03ai8AemxLz2gzfLFzHpHAncf7/328=;
 b=HR7pbcUM6Wh7ojtKwU4LJshAsn8NaqucxXmxjoGZuTjrOixPC8NZLOUgJE+LcCNESpqs1e+iW4BGetx/8PecI0iVxrplWzpJug5g+rphbXAK0K5GSM6/p3p3LPFQHjtDgVo4PxYq3lPS6h0y7se69ClNxHYg2jcLngXSB4RlfReaE4Vx9/SUdxOItlFvWk7wTCIhNtvuc6I9QVXz7EvEB0jeWfx7cy18oX+nYFI6BPLd/1z8SXfmvc6Q183SbtZj3gWSmvQJu+yi3BY1544ackNwyAaoO/FxFvob3dqVCYiEvo9+cDSQG7L0RGYWoIaS2WhZy0dj63ojJVy8twebvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <Chris.Paterson2@renesas.com>
CC: <tho1.nguyendat@toshiba.co.jp>
Subject: RE: Create a shared project to manage LAVA scripts
Thread-Topic: Create a shared project to manage LAVA scripts
Thread-Index: AdhZOpT5o5bNwUdBQVSwy46M9SETfBIU1xLg
Date: Wed, 27 Jul 2022 07:56:12 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB1013617091019ACBDDCBD12A5E1979@OS3PR01MB10136.jpnprd01.prod.outlook.com>
References: <16E960C50D86F043.14553@lists.cip-project.org>
In-Reply-To: <16E960C50D86F043.14553@lists.cip-project.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fe2dc6b-57fd-40be-eda0-08da6fa57980
x-ms-traffictypediagnostic: TYYPR01MB7998:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 o+L7NAVw14IjukjOgd6VViwlhoZCCZbDLi6uK0sFc3caW4wtz2MCoXfT7ysqyzvbPy2pQYhjI6YgeWhuPJSkzl+szy2VE15GlAEjR8wmQn2M4C2d2+Ea1txMYtzcTPVQ9OuGDSUt/xaSTRUghOFvwjv5AYtoIYArL+dkAgZSPI/pWBvLTgb68Ijk/QE9y0mkTQSl8gMacuTHsDAPV9IBVcC6k/z4+zASWN3ckbilzn0v+hBq0XPVe84xMxNC04KkyX/3eCWVEYrJ3j2kNsVRQQpM4ajw4Gb0uiEr0m1t6P+xYrGd8/up0wCR8ejp7JjxOM0Vel1EWnNeUquVskCOyhW/XrWpOFHnFjj09bl4SBUmceMbTVU6fOF3N+S66cuYECwkcFCVOQDxzsy70TrQwYT4itqyWciPnuXZWjSCs1GanjVhGqrJLXfRiYl+dRjhO6Ul3ilc2HrpQ3rrpy9Kx5SZQDoNVDjW4+frjMwH/0pSZKDzNgX3YsRej2xVXP80A8mcC558vShWF0dQL+CuhZuEpMBclWlTTBpGsSI3nG22WXTSZcdOoGPn9+bqJrtOMIYddcNQ6iDrKshEghyZ6tholhM0hQg8Gl/7TKiNc/m3h6mx18gVpC95QOWtn7DfEghx2OE/D8MK57FuWIJGT+s1AcgCrMEa7h7L+8PkaVLyn0ATnNxwGaRIXDBf403Io23J8nUUSIEsQKMIUMfX6DdFqfFAGiwvScosDmVTrgAMoI9B9MQvTgaejPkJW84jjKOZJ96u5sLkdMBMSHWQ9jNYh2Yo11b8EMmcihYGR83pBi35eW24cSbjNp2ZumFyPCx4HAXYScjF/2yllL6WK+RNmRdwMZN3KzAw22JAl1fPcaoMZhF1SToZ5krY5BuF
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10136.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(66446008)(83380400001)(186003)(66556008)(76116006)(66476007)(66946007)(8676002)(64756008)(7696005)(55016003)(6506007)(4326008)(41300700001)(55236004)(5660300002)(26005)(9686003)(107886003)(38070700005)(33656002)(86362001)(38100700002)(52536014)(478600001)(966005)(110136005)(316002)(2906002)(122000001)(71200400001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SE84aHYxZ3o0ajI3TjZURVF5Nk9aU3V0Zy9zdlYrNWd2YVhZaDRVUjFC?=
 =?iso-2022-jp?B?N09ocnlKR1h3blRrK1RZSHQ5SG9hMENBUW9NNkZyTVEveFNVeTcwSEds?=
 =?iso-2022-jp?B?V2lGLzZNQTE3TEhyY3M4dXlLNlJZOFZXN1JndE91ZmkwZ2NubFIrYmRu?=
 =?iso-2022-jp?B?dE1YVWJtdmJobXhJNzVFL1hySnBXeDV2b3dTMm0za1lRVDQ0Q1VxNVVH?=
 =?iso-2022-jp?B?MmVGa2tnTU0ydFF6VUhpMzd4SGZBZ3AwNXFJVU8xNUJiQjcvUXMybk1s?=
 =?iso-2022-jp?B?YVRKblV6MW1SV0NDZWlscGFzb0I4bE9RdnFJMGhFVDJsWjFLcWp2dHM2?=
 =?iso-2022-jp?B?eGcrK0Q4N2RPNGJMcVhLVHYzcjAxZ3dyOFJSbmFaMVVKQytQT3N2QnI4?=
 =?iso-2022-jp?B?S09hRytNdENsdjdiQWdPMGpxc2Frb0c0RkZ2QndKWlVqNWE4TlVVSWJO?=
 =?iso-2022-jp?B?dDFVS3ROMUNGT3hFaTJBa3ozbi91ZkxpUSs5VXZXVXo5cXNORi9peEgr?=
 =?iso-2022-jp?B?OFVXL1czNW1iTHdrVVpQSTB1RWM5NG1NWFRHTUY3R0NXY3MvMDVrUy9Z?=
 =?iso-2022-jp?B?Nmk3ak5ucmFoYXFNSG5tRHdKZ2l3V2xIbFhPUWJ6NlZFQzkzWGhLbFdE?=
 =?iso-2022-jp?B?cHgrSzhDOFpkVCt6aERUVUNKVm5Bd0Q1Z3ZmbGdjbGRIQ2piQ0lPUlZO?=
 =?iso-2022-jp?B?V3R6SEJIdGhKV2NlcmphL0JmcUN4NTJ2NkxNNVFoTU10SkY3ems2SVNQ?=
 =?iso-2022-jp?B?cFpDcUFlVlpwUW1sVyswUWFZYkQvSXpoL2hFSk13YkU1aDVsNFJpeE8w?=
 =?iso-2022-jp?B?UWYwaTRTT2M4TnAya2E4cGI0NUpEMDBoRmFOUUEyZHJrVEl5M3JVZ1Zq?=
 =?iso-2022-jp?B?ekNxWnpiSno0NDV2TEFuaTd2Qzl1MjhBNGNJVmwzRnJFRVJGdVhKTS9k?=
 =?iso-2022-jp?B?RkZTbWV6aHVYTllIWUVTc3cvTndRWkRUam1qaGVKYlo5MlNqUldzRUFp?=
 =?iso-2022-jp?B?cE5wMkc2Y1ZSSVFDcTAzcWxuU21EWDc4aVFwakJlV013QitBb1JzZXRk?=
 =?iso-2022-jp?B?K1NwK2o1SkRyTk9hYzdiUXZmV2tQMGs5WFo5RmtxWnUrcFU1YXVONFp3?=
 =?iso-2022-jp?B?YlhQcUUzblFtZ25BbFl0WTZCM2ZOTHpWYW5mV0RycFZncy8wZ3lqeVFj?=
 =?iso-2022-jp?B?bCtpK2l5SXFuWEZCeFZRVmNiWDVnMEI5ZUtPOHdjVS90NEM1SVQ5bXFo?=
 =?iso-2022-jp?B?WmhzM2J4cisra0lEbzZScTF5bk96Z2c5RnY5eWowdDV4U0dUT0tNdDlC?=
 =?iso-2022-jp?B?bUo4NkFPUjdhV1YxemhKRmZXWGdoOHJvL2MrMkw2VjJ0STY3eFMrZFFu?=
 =?iso-2022-jp?B?WGhDa2J6eHhvY3paRG5qb1EybFkvcm9HeDVhcEZsSmxla3RaMlhESlFX?=
 =?iso-2022-jp?B?eDcyMEcvTDQrSFpvVEZzYWdGY3lpb3JDRzdSTUtmcnQzbmRCcFZCd3FY?=
 =?iso-2022-jp?B?bnV0QnBkQXc5WTBuMVdraVo1RnRrTWI3Qm5KVWVKNVVkd1NiQUw1Q0s0?=
 =?iso-2022-jp?B?bEw0cFVaUEcvM09ua2NuZGx0TWZoZ0xway9VRmhPRHlWbXpRdGRROG5J?=
 =?iso-2022-jp?B?UUtQL1JLU29ITk5HN3ppemx6QW1YWHFXR29HK3Q1YkRiWkFZak5LVkgw?=
 =?iso-2022-jp?B?N2o3WHFRdDlrMmkrZ1UveXA5djJFY3lMd0xyb25ZVlZTbS9rdmt4dFdz?=
 =?iso-2022-jp?B?ajlrcnpqcnM0aEZyVGVBa1V0UlkyRjRzd2hSN0NmblZvZXVBRlV2ZGhD?=
 =?iso-2022-jp?B?MDY3alV6dXhhWGs0aFdXODNSSytjY0k1U3pEUVpEQWROYlk3S2xKZTNj?=
 =?iso-2022-jp?B?MnJEZWdkNkZTTktVai9TUFZDVUVHeXQ1UHozT3RDbjJDMStDTjlHeHAw?=
 =?iso-2022-jp?B?b2RzZVpJWVZqTXFmNXVXTEZqdUtHMXo2UnNWbXIrTVRGSnViODMwbjVm?=
 =?iso-2022-jp?B?QmI5dTZYeCtkR005NmpFU2ZFVFYyQU1BcHRpQWFFYkFsbjIwd0YrZkRl?=
 =?iso-2022-jp?B?V0lza2orZ3hLQ000K04xWXhhaEkzMWdIVmF5VXBnQjNIR1g0SWZOSTcx?=
 =?iso-2022-jp?B?SkJuV0hRcUgwZ2k3MUZ1N2dUZnVZNnduMklCZXRjTzBiYkI3aVg1alkx?=
 =?iso-2022-jp?B?dWF5THFtMDFYVEc4M3I2dGVWZkl2UDZKR3lFT1hNdkpqNktWQ3E4aXF3?=
 =?iso-2022-jp?B?dUZRdlI4bG5qZWtyOTFYRnUxNmNQa3BXZVhhYjN0Yy9qZVhQcEZvVnBH?=
 =?iso-2022-jp?B?aTFZNXJDeFZxWjJ5cjJFMnpCaWR3QlNaMVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10136.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 0fe2dc6b-57fd-40be-eda0-08da6fa57980
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 07:56:12.4813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 KiqRNfePZUlJ5W+KB4yZIUY4HmSittPiXtCrFbA0f8G5C1nlQI5yC1pZbcoMnLUz73gqyAgw7ecv3I9U+xRhaDKvQysU4Azy1/9PfLiSE5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7998
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Jul 2022 07:56:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8952

Hello Chris,

(Rebooted an old topic...)
I have created a project for this topic in cip-playground:
https://gitlab.com/cip-playground/cip-lava-job-submitter
We'll let you know after the minimum functions to submit LAVA jobs have bee=
n implemented.

> Examples:
> https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-/blob/master/sub=
mit_tests.sh
> https://gitlab.com/cip-project/cip-core/deby/-/tree/cip-core-buster/lava

Please let me know if you have any other projects that should use the funct=
ions above.

Best regards,
Kazu

>=20
> Hello Chris,
>=20
> As I created the issue in deby[0], there are duplicated several scripts /=
 data
> to handle LAVA jobs in multiple CIP projects.
>=20
> Examples:
> https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-/blob/master/sub=
mit_tests.sh
> https://gitlab.com/cip-project/cip-core/deby/-/tree/cip-core-buster/lava
>=20
> We are plannning to create a new CIP project that includes common scripts
> to handle such LAVA jobs.
> The new project can be registered as a git submodule in other projects
> (like linux-cip-ci, deby) that depend on the common scripts.
>=20
> Do you think this change is reasonable / feasible?
> If you have any other opinions or concerns, please let me konw.
>=20
> [0] https://gitlab.com/cip-project/cip-core/deby/-/issues/16
>=20
> Best regards,
> Kazu



