Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDC7C27C55
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 06:59:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.35944.1717743579360479098
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jun 2024 23:59:40 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 4576xZwn3198609; Fri, 7 Jun 2024 15:59:35 +0900
X-Iguazu-Qid: 2rWhnhX0c8hSdkvZeM
X-Iguazu-QSIG: v=2; s=0; t=1717743575; q=2rWhnhX0c8hSdkvZeM; m=y9ae+e2vPOUS4DMCMZwhSvExc17JRZs4k9UJEeRapTw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 4576xXlO1540867
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 7 Jun 2024 15:59:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaIr2zrsSyRzM2JTfBYRmwKl+dPzhvOLqyEOltUMquedMpgKl8B74GPL4hqJgsrEAYJ+9+AJ4jRhmokPN+U6JT13HaEFhcXslHfkU4mWHDLE+cR3X02W0QJ+/B8DT/TAgCl2KFNGLF3FOBl9GRz87/52OP3phlKdkAwfcbCkXKIYE/htx4sp/C19wLhCDZPEBi7imxPIXY6CqJHF+zQbpDMJ7SauDfjsTjgkctFh0yE1IN782R5K3auc4Ss5gMO8tp+r75UiXVxWV5ZuytraCnGWnbyXdiN7SFCTl8RWZbn+pEws+Dd2AFaBZh4iL7pd48ufsMBYphjcNAXHD1J3kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jV/QnmjMZ5VZKXQ/vag6fOK1Iq4Nk97jicEOhqn/ZRo=;
 b=jS68pT7NDkGSyG6ozJWgffB/RGn6/e80eATYaAvfSRDAFiqUwrDenCqC/f/o3f+Kk1+yZuPz3RlX+f4VDYKibfmmLKH5O43engv4SA3R7VxHqEbDV2+O5HOJYrUjUuXqCAeqR7a1S8pPNXrLonzDlZ/4NnwxuewG79WE0APQwabJ09WRYAt06fGjNp4fesEPAzh+ylLxV0qWYThh7325Avr2Xsd3dhBf3twmILehKk8/zz8NWNgK+Decr7sSkMwfEQwJNdeYMjEivG0/7s+ozKGay/9H2gqBWEmAXnQ+hA0rbyp4g+OH4J50B5E1zgseHyTFMG7Z2TWvBNp4DVTkHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <cip-dev@lists.cip-project.org>
Subject: RE: [isar-cip-core v2 0/4] Trigger CIP Core testing LAVA jobs
Thread-Topic: [isar-cip-core v2 0/4] Trigger CIP Core testing LAVA jobs
Thread-Index: AQHat16nAWMAkZpXq0+lOfHkVP8dn7G733eA
Date: Fri, 7 Jun 2024 06:59:31 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB61037D2A806B176632766AB8C2FB2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: <20240605154010.3446832-1-Sai.Sathujoda@toshiba-tsip.com>
In-Reply-To: <20240605154010.3446832-1-Sai.Sathujoda@toshiba-tsip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|OSZPR01MB7843:EE_
x-ms-office365-filtering-correlation-id: 5a6ee3c6-c2c1-48cd-40bd-08dc86bf6184
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?aHlFRlR3OE9YNlo1RjV2Y3ZuTHVId3psVzFMblJhb2FpeEl4QXpub2Mv?=
 =?iso-2022-jp?B?K2dTcTlNbHpSVjl5OXFkQW92aG9FdmVMblZ1a2xPQjRKN2NiemsvN3U4?=
 =?iso-2022-jp?B?cHFlZlY5M3B3TzV0WFBHQ2Jud1dNWmpFOWZFVmw4WUk1YWFFWHVDT0pF?=
 =?iso-2022-jp?B?bWNTQ1BpS1lNQVFsQkVMaGRYTFFTM2RZaTY4Z0tkU3hseVA2WmJ4ZzZa?=
 =?iso-2022-jp?B?UVR4ZGx0YytGRmhBMHI0YS81NHNDMzBubTEzRkdrWG9IWGZ5V2F6NmN0?=
 =?iso-2022-jp?B?QUtSdnNrb3Z1cjdZdUVTTkdwUmdlZWRhRjZYQ2diSWF1d2t2U2toU0NJ?=
 =?iso-2022-jp?B?dkpaMnNscHBJMkJVQ29Cc0pIeXlxRC91RWgwck1ZNzh4R29wNzVLaGtj?=
 =?iso-2022-jp?B?VXl1YTdkakZ2TEc4Nnd6YTRvNU1OaEhvbWZYcFl6KytJY2s4eGMrMkg2?=
 =?iso-2022-jp?B?RW0wVzBGNm8wQ1NxczdSaDZwNnF6QytuR011S1FQSzlVaXRtdzE2MUNF?=
 =?iso-2022-jp?B?OXBWczgzY3BsVk00bnVHdXNOcC9XckNtdmg1c2EyMUthdXFJbFFudHdm?=
 =?iso-2022-jp?B?WmVWQ25uUlJ6UmlRVUVLbVJ3RWpOTW9iZkl3N1orMHBhZHgzb0FRTm5S?=
 =?iso-2022-jp?B?dGxoRzlXOHRGcmdKcktzUmpNZ3JXVjJMSytwamZ4cVNMWE8wcGtvZ29B?=
 =?iso-2022-jp?B?a0lLN0dQRzltQTExWklIbk85c1ROTnBHaUZjaE1wdS9hcGN6dWlCdVN0?=
 =?iso-2022-jp?B?OXJ3MVZQaGJnaHhlQlliNXI0TVk5bzF1a0gwTEgvemdTYXJLWFFxTnNq?=
 =?iso-2022-jp?B?dHBiampGcUhqOVRORGs4OHljNEpBR2d0S3dqZ2sxV3VZTEpualBaWkJt?=
 =?iso-2022-jp?B?WG1SOVlLMWxMV0V4ejVRaUpMSHBJdU5XMU9yZ2Z5SkwzY1lMeGh0Tlls?=
 =?iso-2022-jp?B?UW5Ma0diNGJYSWJVdnFIeEtSK0wvbk9JcU5SQVNpSHZkZFB1S1F5ZDh6?=
 =?iso-2022-jp?B?RUppcW1qVGJLdFl4anFMRGlaM3pYQXJJYU00cTg4Z0VYY2NBNlJQMEhG?=
 =?iso-2022-jp?B?K0s0bmN0N0RNamFIb1dIdXErd280MlNxcnRMYmdyV2ExT3lSeEVDOVhX?=
 =?iso-2022-jp?B?c1l6a3F5amgzZ3loRGhVckhMZnBHbXl3VHNIS1hKLzNzSTZpUE9qZFBs?=
 =?iso-2022-jp?B?am1RWDRQWjd0M2gvVzNTVW1sK0pQWkREK1o5dHZEQzJBVzdaL2FKRjRZ?=
 =?iso-2022-jp?B?aXU3S0JwSWxaVUl3S2xWSUFSN0pqN1MxNFk5ajhMVWt4VGxqRE1xQmVv?=
 =?iso-2022-jp?B?K2l3MHJhV3hGNDJQV0V6UXNWSkM4dGhCVWdQVUc3N3hzbG5mYVVUMUN2?=
 =?iso-2022-jp?B?TG9yL0VBL1FOSzF0OERiNVVwSktVV1dmYUdRclovQlJvSG1wRVpwVTZE?=
 =?iso-2022-jp?B?Wk8zRG9VejRISXFPWHMvR3NVUFM2LzFXRDZVQUZ2a3krRUdaTS9UZHNz?=
 =?iso-2022-jp?B?MUZGUEt1Tnd4ZDBWZVFxSFZqUWdGTUk0RDV3aWhOTUx1V2kxYUU1cFh1?=
 =?iso-2022-jp?B?ei8zeC9rNktkTExFOXcwUzNJRjFnNXNHOFFwZFVNcVdzeEdRaFFuRUhG?=
 =?iso-2022-jp?B?Uzh4QmZHTUg5MWNkaER5Lzd0N1B0M21zMHBTOFJyV2Vpa1BJc2hQMllC?=
 =?iso-2022-jp?B?NVBIQWk3THVZVGlBMTdpTnZHY2VpeGpBcmVVcE1PTDQvVCtyckpxY0k2?=
 =?iso-2022-jp?B?enEvOFhoRDdMWkNtYVA3ZjlLL3c1UVdEc3laeFVNWTF1bXZTbmhVb2xN?=
 =?iso-2022-jp?B?cFdwd2VISDBNS08xVHdiRUJ4TDZhZGxORXhRQmNraFlTOGpXNW52dFV1?=
 =?iso-2022-jp?B?TjluNXJuZW4wZ3MvODFTSmVnRUhhcm52R01xaTJKMWxQZTE0bk1rUXBC?=
 =?iso-2022-jp?B?VUdCaVg3dTg3NTV2Yk5QcGoyVlFid2FhRVgyam5XNVBsVHFCMnMreEVY?=
 =?iso-2022-jp?B?MD0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TFNtbTNwZ3NsMkFUeEVib1FYSXpoTzlpRW1lSnNLUlJFUkdkaG1LaExZ?=
 =?iso-2022-jp?B?Qy9yZlZOWnRuUnNyZlFkRHIwNDlMd0FKQ2ZLNm1YKzlsY2toWktaRlNN?=
 =?iso-2022-jp?B?VlFrQWNudyt2TGJHYmRnWGtGcUNQQmVSMjFHM015V1pFalpsaElTck1N?=
 =?iso-2022-jp?B?eDV0eG1mc053Q0F4OWNwOXlVN2UvTXRaZE56cWRpcjROMGRDTU4rZXlk?=
 =?iso-2022-jp?B?bTFBL1FQbzNzK08yVEVpdFg1MzlwTUhJd0dRSXE4cHZWZjVjTXpXemtk?=
 =?iso-2022-jp?B?Y29IeEJqUlFrNEdBRGNGVzUyampEcE5CZktBbTY5dmVSVlBYaVhuMEU2?=
 =?iso-2022-jp?B?TWpBNlVXMGdCTDcwNXgvWm9ZV3M4Rk9ES0UzVnBoZnpmZUpvQXpRQUVU?=
 =?iso-2022-jp?B?SVZTV0cyVU1qSmRwRWZYU09CQjNlM0orZHRSeURmMjVWNENiYnd1K2pj?=
 =?iso-2022-jp?B?Ujl6VTZwUWtZMDlkR3dEYUh5QlQzREl5SHk4dWtaaTRHR3JQV3NCc0NL?=
 =?iso-2022-jp?B?K0FkUEZpa2V5VWh4ZDl6SzVMaThSeTEzZlI1OU14b21lMWF4cTAzNXQ0?=
 =?iso-2022-jp?B?M0dDa25TT25mdUt5UGdIWi96SjdkZmlRSXJqdmpWYlBOWUR2bXJ5endZ?=
 =?iso-2022-jp?B?NnRKOU8wMFZpcFp4QTQrUHFNamdtRndnV0lyMjZzc2NJbDJtb0dicmtv?=
 =?iso-2022-jp?B?Y2RCWTdxY053ZnhhVytCNVhQczM2RXFRRjZ1K05YREpOYnYyN1M0eUdK?=
 =?iso-2022-jp?B?cnlLdHRmNDlocnlHVTF2MC9WTVN5NjhhUHhTeEtoejBSdlMwbENzdzds?=
 =?iso-2022-jp?B?SVFHdktpeEl0MU5hUTY4bE9YTFV6UUlBRWdYNzk3LzhDYlBGLzdET0lk?=
 =?iso-2022-jp?B?SlQzMUFURVFCcUREQzR3aDNaczYxMWZkNG41OEw1RWFRaUtST3RTTm94?=
 =?iso-2022-jp?B?REduOGhGdnhYa084dTF6b3dDeDFoU2NvUzNrZi8xdzQwSTFzeGRYZStF?=
 =?iso-2022-jp?B?aVJzVm1lRHllZkZqZ3htU0szQVZTcTk3N0N5ZDRydmtJbEZsOWkraFZL?=
 =?iso-2022-jp?B?cFdHZkwzSmpQdVhENHBZWlJiMkprR1J2ZE14T1Vjdi93eWNtUnRPTGV4?=
 =?iso-2022-jp?B?MWlHd3pYTmRodmRMTDRjdEtuRlIxNHd5TFBIS1VjUU5iaGZaNStYVm1D?=
 =?iso-2022-jp?B?M0pxNUZFOU9zOExXQWJ0SVllZ2x5eVVyQTcyeDdJdUJNREVkUEV0WFBn?=
 =?iso-2022-jp?B?ZGF5TUdGVW95Rll3dmErWklMTHp6cUN5WU02V21LZGkyUlUvT3NCMHpE?=
 =?iso-2022-jp?B?OXpVdTFXNmkvZEhWMmlZdmlXbkc0dGpUdUpxMWFqRFFBaE1HWGE5aVBB?=
 =?iso-2022-jp?B?OWRrdUdTdm1raHRYbnlwcTlSUHE5K2t2RUhxL0JzZ3JTWDdyRkh0Skl4?=
 =?iso-2022-jp?B?cmVDUnlMVTFYK1JVSlpEWVh5UlBqN0E1NWdpR05IdVlIdnNmUXRtQURl?=
 =?iso-2022-jp?B?V1FTSmszbktrbkNFbVRIM2R2SXRGbkxwNExJYmxXYytVMnpWcjVzQ2RL?=
 =?iso-2022-jp?B?a3kzU1NXdE5NQktyZ1dtV0paUG4rNzJYWk15Wk5Ub1FMRkFOeUZKQzh1?=
 =?iso-2022-jp?B?ejBpaW9EQ09lcDFhTkxJY3JYY2xtSUtOdXRCTUhXeDBrOFJFQ2UzMEJs?=
 =?iso-2022-jp?B?TWVpQ1IybVU5OGJuMVVEcklSdmxsSUlDajROZitiTzJEQ0QwSS8yNDR3?=
 =?iso-2022-jp?B?dWJhd1VkMTA2eFZkcFVjSlk0SnNZV3lZMTZFanRDOXZjRXcxdUZ6dnNj?=
 =?iso-2022-jp?B?Q0xHenFSZnpqTUkyaEhDbElZdjR1bU02Mlk1aXROSzZkcHJaeW9QVU8r?=
 =?iso-2022-jp?B?ZlptR2kvS0FIaTNGMEZoZDcrT2VTWHB1WTlnZ29rT2h5dmdtU1RHdEtC?=
 =?iso-2022-jp?B?aEFEcE1NTVkrU1pEdXNOdmlYb2hPY2F2QkFobmlEbTBCb0djVjhsTXRO?=
 =?iso-2022-jp?B?SHN6eHpjWDMzc0c3aW8zTmxVTUd3eHhVYVZ0aEFteENHRTA4UUc1dGxU?=
 =?iso-2022-jp?B?Q21hZ2dvMkRuZzR2OHo0TGlMZHZ0Sm9HeFdUWStjNlpUaW9ibnFDMjZF?=
 =?iso-2022-jp?B?cWJGbExjZ0tGV3dZUk5lempsMk9sQUJpYjNGS3V1QzB0WGFKZUQ3SlFj?=
 =?iso-2022-jp?B?djJGVTVlelpkbHUwMFdkQ0V6eHNJeUpremtqa0xuS1hwK0hsdmIwUUNF?=
 =?iso-2022-jp?B?blhNVDhaNUtoYWczZXdQUjNuVEh1NGNkR2ZlaHNwVG1VUDI2ZUVjYmFw?=
 =?iso-2022-jp?B?eUV0ZTgyYmZiR2JlaFBqd2E1Yk0zS1RqdGc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6ee3c6-c2c1-48cd-40bd-08dc86bf6184
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 06:59:31.2073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bEWMkEL6SFy4Vj/l4GTKu6vvz71myBuQtmBX0Y2p7RysXnHLrxQZSDRro3Wjvfrka2tUs8THwUWbmJZj01EytGekbYXtPI1CKzXHLpbSap8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7843
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 06:59:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16132

Hi Jan,

Cyber trust and Denx LAVA Labs are updated now. The blocker I mentioned whe=
n v1 patches are sent is resolved. Now the tests present in this series of =
patches can parallelly run on multiple QEMU devices. I confirmed this while=
 I was testing.

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)

-----Original Message-----
From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>=20
Sent: Wednesday, June 5, 2024 9:10 PM
To: cip-dev@lists.cip-project.org; jan.kiszka@siemens.com
Cc: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>; dines=
h kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.co=
m>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D=
#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>
Subject: [isar-cip-core v2 0/4] Trigger CIP Core testing LAVA jobs

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

This series of patches will trigger LAVA jobs which test swupdate, secure b=
oot and IEC layer.

Changes in v2:
- Wrapped boot arguments in template files
- Variabilized artifact URL, branch, architecture
- Added README to briefly explain testing process
- Changed test targets to use small Gitlab runners

sai ashrith sathujoda (4):
  tests/templates: Include functionality based templates
  submit_lava.sh: Add script to submit the jobs prepared from templates
  .gitlab-ci.yml: Add test targets specific for CIP core functionalities
  doc/README.lava-testing.md: Add README to explain CIP Core testing

 .gitlab-ci.yml                          |  33 ++
 doc/README.lava-testing.md              |  30 ++
 scripts/submit_lava.sh                  | 464 ++++++++++++++++++++++++
 tests/templates/IEC_template.yml        |  74 ++++
 tests/templates/secureboot_template.yml |  65 ++++
 tests/templates/swupdate_template.yml   | 125 +++++++
 6 files changed, 791 insertions(+)
 create mode 100644 doc/README.lava-testing.md  create mode 100755 scripts/=
submit_lava.sh  create mode 100644 tests/templates/IEC_template.yml  create=
 mode 100644 tests/templates/secureboot_template.yml
 create mode 100644 tests/templates/swupdate_template.yml

--
2.30.2



