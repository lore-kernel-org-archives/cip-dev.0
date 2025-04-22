Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC7CC369D1
	for <webhook@archiver.kernel.org>; Tue, 22 Apr 2025 17:51:18 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.46807.1745344276629153798
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Apr 2025 10:51:17 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 53MHpDTO3380788; Wed, 23 Apr 2025 02:51:13 +0900
X-Iguazu-Qid: 2yAbyr8UptiSHzavMu
X-Iguazu-QSIG: v=2; s=0; t=1745344272; q=2yAbyr8UptiSHzavMu; m=WstpbAh9+bWWOofAizuO4tQ4LMuheOmlODms4X4VNUY=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 53MHpBxr323159
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 02:51:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9FySW4vQ9ZCF2pst6+kpu6QO9SV/2j1kebPDyuuL12XFqt0W78FswymYowBoRwUgFL5Az2VMKC110Xjx7MRqBSLtsrD7D4X+YJ+aIzr/MeAsQUpPB/M7MNFwN1/UR1eBnZDKpCL8QeFt9YMQFEVCR3XsSMFWVNg0SRYJ2brjrPazC6PLCncc10Y9+KXqhYGSpGyhpCWj0B1QzMyCq+Irtd6OZs5IJBWAH69FAW3k/B99+Wf/2IdcO7RMVEKdPXJT5DQ+Of757Xo9i6HwBjvnpH83LX6ErnAPns+cusZMBsO+ToqljUvpkndZkW34aQ1DE8wqO6k3oegEi+ZAvdSsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7nRX2tE7TfPOpH9gZ/IPyX/v3TMZO02kL+bKQ4iLss=;
 b=fYs8VUAaDuXAy08/QdO/OeYRXjVktu6H3NGu4Xk8AwZDrApZNHcBuVoEypBZBMvYUqmlhrYvo61YRk/qZNnF07k+ki1jEo//bDivvj+TCLWSKZ4K1f2sCMh3IHeaG27FnuNTQWXccv8AXrf1rbWgkpJ/oFF6cs08ICrX34POCig4Voprxf7bJSx54rzNph83O5FdcD4PtqbXuNv3cuDrJdcedPryO2zLYDIEmlIbtJtWH2Vr6M4r8834XrVC2f0knemT9kFOV61dE3og3kJNuBkwpSdvKiio7edU6pt/s5vmuK7VKwncoOOhs3yKs3h82pvt32Aj5Z1pAkOl5X1e3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] [isar-cip-core v5 0/2] Update IEC job timeouts based on
 targets
Thread-Topic: [cip-dev] [isar-cip-core v5 0/2] Update IEC job timeouts based
 on targets
Thread-Index: AQHbs3opd4TpZtqrok2ZyeTYlgKzZ7OvvYiAgAA3I9M=
Date: Tue, 22 Apr 2025 17:51:04 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS7PR01MB148412D8F02FA189FB973B267C2BB2@OS7PR01MB14841.jpnprd01.prod.outlook.com>
References: <20250422112751.3620163-1-Sai.Sathujoda@toshiba-tsip.com>
 <79d61200-975a-41a4-8f46-5fe5bf3ead1b@siemens.com>
In-Reply-To: <79d61200-975a-41a4-8f46-5fe5bf3ead1b@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB14841:EE_|OSZPR01MB8436:EE_
x-ms-office365-filtering-correlation-id: 785d3b6c-b9ac-40f5-3100-08dd81c640d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|8096899003|7053199007;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?SHphT1Z1RS9ZQlc5S2lORXhKVnBGL1RPQ0FpSk1nYm1SVGFxdTk5QjVX?=
 =?iso-2022-jp?B?TExaNWhmMDNva21hMmRZNGQ1RUlMQUMrR3o2WTJ3UExHSmdBTjJxd0VF?=
 =?iso-2022-jp?B?UEQvaDJXQXJXaHUxMlJWZjRuWUIzUDZhdFR0dW12VStPNS9XcGxmOWll?=
 =?iso-2022-jp?B?c0FPeFdvN3N3NXdvdEhWWlpQRW4zMytYNGMxV0NKL3FKKzNLaVFSdHFC?=
 =?iso-2022-jp?B?b05GQ0Y4amNYeHM0VnBuYzFqNGdVL2FUUmtJZ2ZlK0gvbVp4Q3BGQ1Nm?=
 =?iso-2022-jp?B?eFE2MHE4U05QeXJLaEI5QXV6UXU3WTVhUWFPRFJnTjBjMENxczZIekYx?=
 =?iso-2022-jp?B?eko2ME9LQ2h1bVpUUFg0dHdkMVowV2F1OS9qZEgxVlFUaUIrdmlkVXhx?=
 =?iso-2022-jp?B?ankxK1IwOG8yRzJscWo4UlN1NEFxWVdRTXd4YUtOYk1vMFkweXFUU2pt?=
 =?iso-2022-jp?B?Y0xBVHUrdXB3U1FrUFZTb0FMR050ZVJacDBTd3lVWGdITG9YSFdNd2hO?=
 =?iso-2022-jp?B?VDJpVi9SQkFPcUxYY1AyOXlvYmJuVldVSEZEb3J3ZUR0dXJGc1A3MXpj?=
 =?iso-2022-jp?B?MzlVVURQMzFtUzUyNHRQeUg1YkF6SjgrY3h3d0hBcnI1V2UxcTVpc05H?=
 =?iso-2022-jp?B?c2JFZHVEdmFhdEZ5OWVKclBSaXY4bThBaUlSaVZwMmkvV1hYYWc4YzVk?=
 =?iso-2022-jp?B?Mk41VVA0b0pmWElXbE9WY2tja2x1QnlhY2NhZW1wMVgwS3FRdFlNVEN6?=
 =?iso-2022-jp?B?T3NjNkRXN2dDSUVHSXhHSWc0cjFHVHpWNkUxcTRLYlV0M1cySUdqUnB4?=
 =?iso-2022-jp?B?d0pIMHdPVTJnYTcydXFNQ2liVmx4aDlWV0dUQ3ZiNllYSk5YL2phMmtQ?=
 =?iso-2022-jp?B?d0JkeWJqblluS1MrS29tcFpmajBxUGllZnlqcXhVTGIxRUs2MlVobysx?=
 =?iso-2022-jp?B?N0txdTc5Y1JyTzhPUVoxMnk3SEM3bGkrMG5YRUFHZVhiRjVybmhyK0hu?=
 =?iso-2022-jp?B?TDRuVUhhWU91OHdZZU0wYmkrbjV2UmlUczIxUnVUVW91eUhOaytUYTVL?=
 =?iso-2022-jp?B?VXJHUVVKcGhWaVpRbjF1dzU2VWtBem01aWx3NXROalpGZU1vOWR3K2FO?=
 =?iso-2022-jp?B?SEFJd0FYUEVWN2NCQW1McmVqNE9NTmVZRDR5bzBkekw1d0lqeG84NWh5?=
 =?iso-2022-jp?B?UmR6VTJQdTI2cnNMMmdhVTZCS3RXbXAxZ05WNktiM2VSSUxkcmo5WkFl?=
 =?iso-2022-jp?B?Z3phUHdDcmthb0ppUWRGd2s3emJHNlNweWtWcS93T1N3REY5cDlWTWQ0?=
 =?iso-2022-jp?B?Z2dtcGUzRFdTOXRKV2RWb3JBTHJFNzIwL2U2RzJhRTFHWW5Tb3B4aGdx?=
 =?iso-2022-jp?B?WVREMEV0Y2VVcm4yMVVuYnNnSmQ4SGNFdDRSR21DQXRudXdTU1JLdU42?=
 =?iso-2022-jp?B?YzVMZ2pJaTVtR3FydGtiS080MWJmZDdZSGRLVGsrcVZpdlVaL2hZRFdx?=
 =?iso-2022-jp?B?UmFZcEJJK01jV003d0kwYW5UTDR1T2RScXp3VXB5OVZwaEZ6c2ZWREEr?=
 =?iso-2022-jp?B?OXg5WHd3dXdlNmxrbTNFK0crTzhUUTBxYWhSSmdPdnhSUHQ1V2VmaC9h?=
 =?iso-2022-jp?B?ZTdUMkFWRndiSXFVZE9OcUk1UHNRNm9IdjZsSEJKb3RjNnRMV1NWNGE3?=
 =?iso-2022-jp?B?R1ZDa041NVlDWWlxVjg5T2JSQjRVdGgwNGEwQVp5Q1hwMnRXZUtXT1Rr?=
 =?iso-2022-jp?B?U2NzQ1NVanRsUUZqUFBPeEFjRWc3YmlWK1RmTE9RK29ZclErZTZ5VnU5?=
 =?iso-2022-jp?B?QjBUWXpsRXFPdWFwZVFyeDJsd0d0ZDE5dGVwbldlS2dTbUhCTjhtalpk?=
 =?iso-2022-jp?B?RTFtQmM4Q2lWNExodEVXSVE0WjErQ3ltMzdOZVUrQkFHcjVPbTREdko3?=
 =?iso-2022-jp?B?dzMrcjBVakVPb2RBYTJwMXZzR25QNjMvMGJjWkZmTVFOZTZhbWV1NExH?=
 =?iso-2022-jp?B?eGY2ZU4rV3R0NVhidFhKWVJZdS83alIzRnRFUmVWbkVnYWdOL0Rjb0pv?=
 =?iso-2022-jp?B?Q1drVDZoZEN1NjZ6Y3hPUFhwOWI4Nlk9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS7PR01MB14841.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(8096899003)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RWp3eTRmMGVpSm5ualk3dC9Yc2JrWE91dytQczN4V0I1S2Y1THp2N0xo?=
 =?iso-2022-jp?B?VzY5L3k4MVhrK29UUlYycmxVRWpSNUJ3NmJ2bGovWXRTMDJiWGpDZHVC?=
 =?iso-2022-jp?B?SktwUDRuR3ZhMlZ0NXlZRlZacXRucy9mMGczRVRCUEFIRnRYK1pnS0ZB?=
 =?iso-2022-jp?B?TjUwSk1ERG1aN1ZNZmhmeVlITFRaS2ZDMU45MnhMc1lJVjdNMjc0Z2ht?=
 =?iso-2022-jp?B?LzREZWtlUGpEQlVIZHVCbElUWUJVNGpQMFVGeW40NDNGR0MyRXNCZ3Qw?=
 =?iso-2022-jp?B?N3NPTVBOSFREV3k5blBkTzhUenJ0d3VVN05DMUd6cGV3NnhMTzE0UWpF?=
 =?iso-2022-jp?B?WTZ1R0JKYkh4clN4K1dTWnFIUnVpN3VFdlpabkFuSzlYYnFEdEtCY0Y4?=
 =?iso-2022-jp?B?L0x3UFJtQTdkWkRJL2t6eGZJNEpDSVA5blpVU2orRFJiWXZqOUtWL05U?=
 =?iso-2022-jp?B?YzgwTkhzK1JvOVZUaEtKVXIvdGVuQkZhTE9nbkU2L3MzVm1ZMUErTmNK?=
 =?iso-2022-jp?B?WFpLeDRBb1JLeW9mT2hBZlczUVJjTUdRcjJBeUl2RmpFV1FhTUF6d0ZK?=
 =?iso-2022-jp?B?Rk9sVXBCUGtXYUFTaFhwQ0o1Qy83L1ZxWVR6UjBnTjR6eEhTRVJKbkQr?=
 =?iso-2022-jp?B?V2VrdTR1TUhCbUMvc1NTaDROZWdCek8wUXNLQlZQTy9BbjQxdklXL1NR?=
 =?iso-2022-jp?B?NXdxUzZ2UWlhOTFCQUdyWkovNHhLSW10OEwwbkJVN2V1RDNva25CSW96?=
 =?iso-2022-jp?B?d1ZoTFg3TkZQV1F5QnVONk5VUkEybnhtUWUvbUErN3MvR2R3dVZsZ001?=
 =?iso-2022-jp?B?c0szQS9kVmVSK3Jzd1VuTmN4WUQ5UEY5RXlMcHFHTHYzbm10dWg0S0Er?=
 =?iso-2022-jp?B?WDZTQkhKdnFIb093cHljQVJXSnNrK0FsaTZ5LzBNZmMvZFRZMG5rYkxH?=
 =?iso-2022-jp?B?QnplZnhmaXIxOXRQb08rRzZzRXFpL0RlNTRBZGd5ZUZrV2E0SUZKSkJY?=
 =?iso-2022-jp?B?QS9LWS95VWNheWU4YjZzdldiR3o5Q2s5SWRDa2RyL0htZnVOU2laaDZ2?=
 =?iso-2022-jp?B?RzVuTzh0TGVDVi9rajlVY0c1dWYxODd2QlcwY1BKM0JGYm9vN2Vva0tN?=
 =?iso-2022-jp?B?T244NzlYU2lFODFvZ1NLS0ZHMzVibXZzcGFaRXB0K25tZkNvZHJ1L0JP?=
 =?iso-2022-jp?B?T25XTjRlN05Da2hPWkdNVkZkUDdaL0p0aW0waVlDLy9Md1c4cnNCNnNs?=
 =?iso-2022-jp?B?YWdySmFDKzMwMjhoK3BYTUVBQTBoYWVDVVpkQ0tNRS92Yis5TFA5RUxD?=
 =?iso-2022-jp?B?bElTUE0xRUdsc25GdTNoU3JvQjViSzhLVkpacm5FdXN0eXlNcXF5amI5?=
 =?iso-2022-jp?B?NFp3NVhwN1Z4ZFkvZ0ZYUkFQUmlqS1l5aVhUQ1JTU0VKazBvZGhHdkM0?=
 =?iso-2022-jp?B?WFhMdmR5Q082R0E1a1h3cUVpcHRNb3NjYktlUTdRd2dZTHJXc21oYUlu?=
 =?iso-2022-jp?B?K0RIbythS3lhamhIQWowZHFKUFgvT0VEZ0pXVmx0SEpJWXdFSUx3dVVJ?=
 =?iso-2022-jp?B?YzdRWWRnYS9uYTJYRG1ZeG5LbldjaVRPMkczQVhBUlhlVE5rVDdQR0FE?=
 =?iso-2022-jp?B?MzdnR0lNUm9oTmRRSStsV1pvaGlWeDlmcGM3SENNSWRHbXY2SlhuRGtM?=
 =?iso-2022-jp?B?K3poeUNFY2FpaVVEUGk5bC9FaWV6bW5sK3JwR2FHMUdyT1Q4WXA2dkNx?=
 =?iso-2022-jp?B?SzlCdERTbGtCUE5aSXhSUkowNExRWEpESGJ2UGVVTXhzNHAvYWFZTGk5?=
 =?iso-2022-jp?B?bVUvenJRTU9zbVpySWg2dG1WTFAxRVM0YjBMbktYT1dJaFZaQitxZkJk?=
 =?iso-2022-jp?B?UWtBUjNTaXBYVzd2TUVmUlZTTVJQVFY1bGNpVFJnNFYzTGRDK2xCMzNy?=
 =?iso-2022-jp?B?YTNMbnYwOGxMbEFNa1A4SVp2Y3p5THdFYUZMcWp0Y0NpcUF0MFVzZFF2?=
 =?iso-2022-jp?B?N3MweUNwMVZpbmtJMHUzZjRCRkdHV2wzSWROYXNSQSs1R1BoY3VzbXg1?=
 =?iso-2022-jp?B?dmRYUUZOc1RBMzZteERMZ1dqc1FoZUtEdGVsa3AydExsSU44YmJIMTBE?=
 =?iso-2022-jp?B?UWJCSTBtdHhPdVlBZXNSeERLbkE1aXJlN2FjZEl2VnBVcENDaHBkbU1i?=
 =?iso-2022-jp?B?Y0d2YU94eVRuUUVDZWplVXVVbDkwaXh1bmJxRm1KYndZdGxhREhPbndH?=
 =?iso-2022-jp?B?bGNsbGpFbGFXYmVZdFNuc2RNOWM1aFhxb2pQTjlUMG05dWRUaEFBaGlP?=
 =?iso-2022-jp?B?RjdZYW9zdFJ3TXlQK3V2RFVrWVFhcEViQnc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS7PR01MB148412D8F02FA189FB973B267C2BB2OS7PR01MB14841jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB14841.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 785d3b6c-b9ac-40f5-3100-08dd81c640d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 17:51:04.6898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AmWaPksJdb3SfJscg8RIN+hCgNWD9/sw0qLbGMWV3v64wfpeNPm2vL6LZRE7Vfj6C/FA5rTifFzLS6c5j7sOSgtLJhdbxK++tRxdPer9xV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8436
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Apr 2025 17:51:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18563

--_000_OS7PR01MB148412D8F02FA189FB973B267C2BB2OS7PR01MB14841jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

After recent observations from last 3 to 4 weeks, I found that some times 4=
0 minutes of time for the IEC test execution (44 tests) on M-COM x86 is not=
 sufficient in some rare cases. That is why i sent the patches to increase =
the timeout from 40 minutes to 60 minutes in case of M-COM x86.

That is why I have increased the timeout for running those 44 tests from 40=
 minutes to 60 minutes with the confidence that this test shell timeout rar=
e case can be ruled out. But now on the pipeline triggered by you on next, =
I observed even 60 minutes is also not enough in some cases to run those 44=
 cases. LAVA | Scheduler | Jobs | 1266235<https://lava.ciplatform.org/sched=
uler/job/1266235>. I verified before sending patches and I did not face thi=
s timeout issue with 60 minutes timeout.

Currently I have no idea how to handle this timeout problem. Do you think i=
ncreasing the test shell timeout to run IEC tests on M-COM x86 further to a=
 value like 120 minutes can be the only solution to fix this ? Can you plea=
se provide your opinion on this issue ?

Thanks and regards,
Sai Ashrith
________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Jan Kiszka via lists.cip-project.org <jan.kiszka=3Dsiemens.com@lists.=
cip-project.org>
Sent: Tuesday, April 22, 2025 7:54 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <Sai.Sathujoda@toshiba-tsi=
p.com>; cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <dinesh.kumar@toshiba-tsi=
p.com>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B""#D#I#T#C!{#C#P#=
T=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [cip-dev] [isar-cip-core v5 0/2] Update IEC job timeouts based=
 on targets

On 22.04.25 13:27, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
>
> This series sets IEC test jobs timeouts based on the targets as well as u=
pdates
> IEC layer tests revision
>
> Changes apart from v4
>
> 1. Modified usage of envsusbst to substitute only "IEC_TEST_TIMEOUT_MINUT=
ES".
> sai ashrith sathujoda (2):
>   .gitlab-ci.yml: Set timeout value to run IEC layer tests for different
>     targets.
>   IEC_template.yml: Update IEC layer tests revision
>
>  .gitlab-ci.yml                   | 6 +++++-
>  scripts/submit_lava.sh           | 7 +++++++
>  tests/templates/IEC_template.yml | 4 ++--
>  3 files changed, 14 insertions(+), 3 deletions(-)
>

Thanks, replace v4 with this version in next.

Jan

--
Siemens AG, Foundational Technologies
Linux Expert Center

--_000_OS7PR01MB148412D8F02FA189FB973B267C2BB2OS7PR01MB14841jp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi Jan,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
After recent observations from last 3 to 4 weeks, I found that some times 4=
0 minutes of time for the IEC test execution (44 tests) on M-COM x86 is not=
 sufficient in some rare cases. That is why i sent the patches to increase =
the timeout from 40 minutes to 60
 minutes in case of M-COM x86.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
That is why I have increased the timeout for running those 44 tests from 40=
 minutes to 60 minutes with the confidence that this test shell timeout rar=
e case can be ruled out. But now on the pipeline triggered by you on
<b>next</b>, I observed even 60 minutes is also not enough in some cases to=
 run those 44 cases.
<a href=3D"https://lava.ciplatform.org/scheduler/job/1266235" id=3D"LPlnkOW=
Af56b3a31-3233-9452-12d6-5771b48bddf5" class=3D"OWAAutoLink elementToProof"=
>
LAVA | Scheduler | Jobs | 1266235</a>. I verified before sending patches an=
d I did not face this timeout issue with 60 minutes timeout.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Currently I have no idea how to handle this timeout problem. Do you think i=
ncreasing the test shell timeout to run IEC tests on M-COM x86 further to a=
 value like 120 minutes can be the only solution to fix this ? Can you plea=
se provide your opinion on this
 issue ?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks and regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sai Ashrith</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> cip-dev@lists.cip-pro=
ject.org &lt;cip-dev@lists.cip-project.org&gt; on behalf of Jan Kiszka via =
lists.cip-project.org &lt;jan.kiszka=3Dsiemens.com@lists.cip-project.org&gt=
;<br>
<b>Sent:</b> Tuesday, April 22, 2025 7:54 PM<br>
<b>To:</b> ashrith sai(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) &lt;Sai.Sathujoda@t=
oshiba-tsip.com&gt;; cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-pr=
oject.org&gt;<br>
<b>Cc:</b> dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) &lt;dinesh.kumar@t=
oshiba-tsip.com&gt;; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B""#D=
#I#T#C!{#C#P#T=1B(B) &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;<br>
<b>Subject:</b> Re: [cip-dev] [isar-cip-core v5 0/2] Update IEC job timeout=
s based on targets</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 22.04.25 13:27, Sai.Sathujoda@toshiba-tsip.com =
wrote:<br>
&gt; From: sai ashrith sathujoda &lt;sai.sathujoda@toshiba-tsip.com&gt;<br>
&gt; <br>
&gt; This series sets IEC test jobs timeouts based on the targets as well a=
s updates<br>
&gt; IEC layer tests revision<br>
&gt; <br>
&gt; Changes apart from v4<br>
&gt; <br>
&gt; 1. Modified usage of envsusbst to substitute only &quot;IEC_TEST_TIMEO=
UT_MINUTES&quot;.<br>
&gt; sai ashrith sathujoda (2):<br>
&gt;&nbsp;&nbsp; .gitlab-ci.yml: Set timeout value to run IEC layer tests f=
or different<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; targets.<br>
&gt;&nbsp;&nbsp; IEC_template.yml: Update IEC layer tests revision<br>
&gt; <br>
&gt;&nbsp; .gitlab-ci.yml&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 6 +++++-<br>
&gt;&nbsp; scripts/submit_lava.sh&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; | 7 +++++++<br>
&gt;&nbsp; tests/templates/IEC_template.yml | 4 ++--<br>
&gt;&nbsp; 3 files changed, 14 insertions(+), 3 deletions(-)<br>
&gt; <br>
<br>
Thanks, replace v4 with this version in next.<br>
<br>
Jan<br>
<br>
-- <br>
Siemens AG, Foundational Technologies<br>
Linux Expert Center<br>
</div>
</span></font></div>
</body>
</html>

--_000_OS7PR01MB148412D8F02FA189FB973B267C2BB2OS7PR01MB14841jp_--


