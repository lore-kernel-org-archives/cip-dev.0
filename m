Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E032D41D50
	for <webhook@archiver.kernel.org>; Tue, 12 Nov 2024 04:14:24 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.79084.1731384853155331235
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Nov 2024 20:14:14 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 4AC4E8tE1826851; Tue, 12 Nov 2024 13:14:09 +0900
X-Iguazu-Qid: 2rWgUXum7A7YUT9IWv
X-Iguazu-QSIG: v=2; s=0; t=1731384848; q=2rWgUXum7A7YUT9IWv; m=7E7WHMBOkdXOTMOy1lR+ooLABOKk3DhUCs/VIVDZtN8=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 4AC4E7xt351926
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 13:14:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWMdFmhKlVY+Lwef+9QNyIxeHJa5ATuZPomUja6NXjkpISS+KwJvel+/toEqUtVrSck7b2FisZengzO8N2xI+hhZ9Wnd3YN7NYoeQCRZ8ttpoUCCXS0+Se9Vf7WRF3E2l5coPLzUNy7vjceafuAYMm+MmhnLXTrMKdEwJNKCs+JAKZQkLKyCU8AEPqB8F+EldDnbgVKvWv9GJCW7iA+CCKtVx49dVSWAWf5PHtRU4jqo6wzX9Ft5LeCX0lD8NeKcf7TBZxrISu5FlIO1oN0B5sdWh9tLWlR5OSEuMSn/coguya16cArSLUj00XLl4qUwo9JfV5heXyNf3ccRH/7WpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vetMf4PgUVJgWVkcCok5E5E1WlQMwo6+mps3uYA7hcQ=;
 b=ko6df7/QFtlQsHYmqUtdxS162E9DsqzCyFACSFWanXZE6g37gkHlFqe4M4EzU5dEVBW3VEJruYboU2z/XyY8N73iXCjAq22PCsdgX0CxgayqZcFkgZppaezacJGhRHiRboS9v2Ovg6VVLri/Aqu3vMcTl9BUya1hvuWaPLtaRInN7Dq/T27mKEZu1iiQa5buyzLeKlM8SFci1qDDogXr9PGjRaHZeZ+mzdr4e2jUO32zCytIjD1nyNf3u/LhrCIgrFcLmRWPf+sMJOjT9sNnz9IH/0ag/Mugp8WjzHHkdUpMqGj6r8cdexXrqyS4OCYykYvtBXpm0oviGfdTsoNOYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <dinesh.kumar@toshiba-tsip.com>, <cip-security@lists.cip-project.org>
Subject: Manually run Kernel and IEC tests on M-COM x86 and generate results
Thread-Topic: Manually run Kernel and IEC tests on M-COM x86 and generate
 results
Thread-Index: AQHbNLcv3vC8deZB0Ua07zkQ6b5nXg==
Date: Tue, 12 Nov 2024 04:14:04 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103AC4F03F328776A6DFBCBC2592@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYYPR01MB13546:EE_
x-ms-office365-filtering-correlation-id: a61309c4-e9cf-4bab-f442-08dd02d07231
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|8096899003|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?K0xlK25rOUlTck9KN2h5V0lyMUtFMXI0eGtNVXFTb0hQcnpPZGVrR09Q?=
 =?iso-2022-jp?B?ZnN1OEpLRnpSYmtZbzVMa2tCVzVsR0t5NmlxSzNXRDE0ek9HWi9DSTMy?=
 =?iso-2022-jp?B?L3VkeTQvU1BBU0trM01QVG9scFAweDRJRnRIOW9VRkVnYVVMQXhiU2hi?=
 =?iso-2022-jp?B?RFdSMTVqT282K3VDZXVobGIvZUJ2amxmbjlPeHY4Q2lqd2NMLzNvdWV0?=
 =?iso-2022-jp?B?bWo4UnlKKy9nSWZjYkNaMkxjSzgxWGxlazVNdEdGY2NtK1poNC81NUVJ?=
 =?iso-2022-jp?B?NzhsV1lreDd3cFphWEpjQ0JjZUpndFNockp6dXBhMFRzRUZPdlJ4S0Vi?=
 =?iso-2022-jp?B?cWQ0RHdpckUrenpXTjB5RUczMmdBNVo4OG80S09ZZi83OFVzUnZuS3h0?=
 =?iso-2022-jp?B?TU94OTgzbnJGbHNXNWZxMXZ3dmNYTXRocjJJMnpLWFNUOVU4TGxicFNH?=
 =?iso-2022-jp?B?UDJwV1Q0UDZHWDhBVzN1Q0lOYzFJMGY0SzhWdXdBY2Q0M2VKWTliTHky?=
 =?iso-2022-jp?B?Zk1EbnR6cHIrbFJId29NUnMwR2ZCc0Q1N3hwR3ozOExtdXZpaW1DM2Ey?=
 =?iso-2022-jp?B?K3JQMms5ZURNUVdkQllGcUJrUEdHVXo4VmlYbUwySG50Rk1lMGVDVlJB?=
 =?iso-2022-jp?B?NjdqTnRqSWhvWVJkZlY0LzBHM2tHcFhwVXREQ0hxd01VMk1ORVgwckEy?=
 =?iso-2022-jp?B?dStwcVZQTnZKdEdyL3NLMlhTbSt1Q3RzUlh0a3QrU3dkZUJuV0NLSE53?=
 =?iso-2022-jp?B?RzRyMUliNC9Ec0wzZ09sMWVKanU0eDNZaGpOVEtvcnN3elZFNCt3RlNY?=
 =?iso-2022-jp?B?N3J2VWN5Y1M2cWxNYTRDaUNUcExoOHdDeHZhNEpEQWthaWRRRjFrT1NP?=
 =?iso-2022-jp?B?R3UrMTRSVWNmNjAwdWh2LzJJYmpuL3dqVzFubEw5R2kxZG9tQXB4VmdM?=
 =?iso-2022-jp?B?SkVmaWprVFM0S1hjeEtiR1E4Nlo2NExGb09pZ2FYeXE5WWJrSXdUazd3?=
 =?iso-2022-jp?B?a2gxb1lxUUtyV1pQLy91MDZDZzlqNytBd2FnYUt6LzhIVThwVStmSDNi?=
 =?iso-2022-jp?B?WldzVzJjRnFLdGJkL0hPMlg4S1JGSlhNcm0wM295eTRLOHkxVHkyVnh5?=
 =?iso-2022-jp?B?WlhhR056UnZrSlNaUDNKUUZIeDhOMkJTb2V2NThaWFozOFRKclQ0Z3RD?=
 =?iso-2022-jp?B?WjFrQ1I4bjNocnZGZ0NUN3hBK2R5VkwramlabzZldzhqcXdkbEdzQ0x2?=
 =?iso-2022-jp?B?K0ZyTE0rYmxoTy91S1VYVThBaFZUalRUWTdXSFIwbnlGRU1yR2tEbWND?=
 =?iso-2022-jp?B?eHl0WFFoMDBDSkgwZGFsWjg0K2xsUW4xWVVtVlA1RzBpSS9DREZ6SHVl?=
 =?iso-2022-jp?B?cG12ZmI0b2tVcmxjZ3JzTDVQQzFBQTNwSnBSZTl2TzMvYUdmalBxK0g1?=
 =?iso-2022-jp?B?dDdaWVlqMDNvek9uM24yeUMvOGdzVTJGQTVubjFoOVFHMFJTVytpMEd6?=
 =?iso-2022-jp?B?aEM2V1MwZ0cwNEh1dHNjL2RXTUduLzZnSUdjNWNlTW9JdldNWlVSOUUv?=
 =?iso-2022-jp?B?Wk5tZG5zT3pRbEJXYWNUMXoySFFFWCs3dkEwcVJ3MVNMZjJ6M3NpcXVn?=
 =?iso-2022-jp?B?S0cvbWxlS0RpY1YzV09yNVRud25LdVV0RXlSNmNNSk9KQlRGL1RPS0dP?=
 =?iso-2022-jp?B?eHZOaCtGTWhtZ3Z2RjdCMlFYY2pCSTBVZU9sN0lOSWVtZ0d5NWFMdjIw?=
 =?iso-2022-jp?B?ckRRZnZDMTVrWERwME40WS93OU8zd3RWb1U1UE11RnU4czIvR1hsRjhE?=
 =?iso-2022-jp?B?VmQyRklaSnlnRys5UWlaNjFRM0VJU1dJS2hrZy9rUEwxNk1sYU1Teldv?=
 =?iso-2022-jp?B?TjRnbWc0UjR0YU8rbHA3ek9Wek1HbVROSzVKdExyQXdleEhOdnh3dVdO?=
 =?iso-2022-jp?B?c0dIcW1xZWFvcDgzYlRlRjJHTEtLdz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(8096899003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Z3pJeTNZd05zZkFYcVZRNlFISDg3aVVWUTRwWi9JQXZOajBHUEhBQkpw?=
 =?iso-2022-jp?B?YUc2Vjk3Q3BzSWIzN3BiUHFSYUl2YXphcm9BaWw0aEcrQmxNNlFWQUZS?=
 =?iso-2022-jp?B?Qm0yRUVtY09DWGJiK0xtbHpRM1UxNWJDVTFGYVM0VFNGcjk5enJvb08r?=
 =?iso-2022-jp?B?R1Ewd2VTNS9SWlhyTlFUSkRsTG1wVmVuQWphNU8wNkwrUXArVFk5aWxQ?=
 =?iso-2022-jp?B?SFVzNXBWWXZCcFpkMm9kMXMycU5IYlFKMStnVWJyeHpBQnY1elNsTUVx?=
 =?iso-2022-jp?B?Wk5FekovZmNWZWtPOCsrRVcreWZXT3JSNkxINDR6Z0JHa3IxMGlyenFt?=
 =?iso-2022-jp?B?ZEtHR0E1d3AxOXZSOG1tS3d4ZkIvZEl1U1AwMXVYNzlXZGdOODM5ZU9C?=
 =?iso-2022-jp?B?WWQvdnJOZUlSYisyQmgvOFdvd2JtTzEvZVZETU1DY2ZSODNRRnhEbnND?=
 =?iso-2022-jp?B?dmhJTlFiM1VnSzRrdGx5UGxpT281L1liYzJRWTJRcjhVMDBwOGNoY1ZB?=
 =?iso-2022-jp?B?TDdIeGdEWGpDSmJwY21PZ3lWT01RQlhGdEtlNDlhZWNSMWtYcWRZK3RE?=
 =?iso-2022-jp?B?S2JGRERYeFYvelhuTUU4aVBkQ1NRR2N3NkVHMWN3NzVoMzZjaENCV1Mr?=
 =?iso-2022-jp?B?L1pIQlAxYjhoTGMrY01ENFV0ZlpHNi9rWmNPM3pEVHh0eFZnYnZ0eFJz?=
 =?iso-2022-jp?B?OG1NdFZ5NTZaQ0g2Z3ZqS3psUThsOFJWWUlsQ3p0eDgxeXhzQzRsVmNO?=
 =?iso-2022-jp?B?Nnhva3dpcjJEU2lZc0ZIWjk3dVlwNkhHMGpzdEU0NTRvOTFnZko2VGp2?=
 =?iso-2022-jp?B?QmEvaHA1QTlCTUVXYlJjcWxuYnk0YnhlV2xmbHluRWIwdDgyZTM4eVA3?=
 =?iso-2022-jp?B?c1BaMjV1bWFjbnNReXBUcGIybkVsVmxaeEZNNmxZcElqaWtIQXk4Tnha?=
 =?iso-2022-jp?B?MEJiUUZtZVVGWFV4T0pSNmR6VnRhYUJRMm5zREljWVZiY1F2alVScFhr?=
 =?iso-2022-jp?B?akFiOHFGb2x1NGFYUjRiWU5pY0NBeXMwUVdOKzhxamNWa201T2hlNE1m?=
 =?iso-2022-jp?B?czN2ZS9JM2RUa25Ob2h4aFphYXlVMTJ1ck1LZmhya2ZyZHF5UG5JNWZN?=
 =?iso-2022-jp?B?L2NnS2FvclFmdjJFVzNsM25ZMndEb1pQSjhvNm8zM3VXTWFpWUd2eVR5?=
 =?iso-2022-jp?B?aitybzAyeVA2eVlVLys2NEdMclVXallMa2RuVWVuNjR6blNMZlJsY2Yx?=
 =?iso-2022-jp?B?b1g3cytybVBNTzQyV1dBZ3JDKzFlUXYzWG10OEVMYnhXRWY1K2Y5Y3g5?=
 =?iso-2022-jp?B?YkEvd0hpRXpSOCtYdmNyQjEzdFRPK0FoTlBLeXRsWXkydVdtNEtyZDBo?=
 =?iso-2022-jp?B?RkxlTStWS1ZvR2VvbGpTcmZmcjFXRjQ3TDBLUXl3VFcyZ09xUDFjSzlu?=
 =?iso-2022-jp?B?cUdaZFRNWDZVVVZJcW9mek5Zd2pLMno4bW12amZMNmZQRm5YbjZVaDY2?=
 =?iso-2022-jp?B?K2YzNUU1bmFBUFJrOEpjN1lMcWhUOSttMElCSzl2d0dpRkpBUk1oR2RW?=
 =?iso-2022-jp?B?WFZqaGVxdml0ZUZMNllZYXlmS1Bva2FQMGZPQWhKWVdyVDRaTGwyT0t2?=
 =?iso-2022-jp?B?NzlHT09pVW0vYnh4c0Jvd3FtQzBQbStueTZ3a1kzcnJtMjVMZXRBRWh0?=
 =?iso-2022-jp?B?bVF3dGRISTFFVFJ4RnVtV1JNbFVSM1B5NURnY3Rzc3JKS3lDNU9Ub2l1?=
 =?iso-2022-jp?B?SDFMYld5MzlIV3VFc0RUL3lYYm9naDQ0RlowMVNmYUYvekh0ZjhuVGIw?=
 =?iso-2022-jp?B?eHh5VUlPQXhqNW01aGNIeXpVd1JtU1BDSGo0RmFSNXAvWFc3QUE2V0dr?=
 =?iso-2022-jp?B?aFBXbmlXOU9qK0FnZjRDN1RrOHIwcVBVeitKVkhaR0E5REpQMkRhbW1u?=
 =?iso-2022-jp?B?MEVXZTB6VjlrVW51ZjBkK1FPQ0owaU9TV25pVmNQVXpCWFQ3eE5DcW5B?=
 =?iso-2022-jp?B?ZVVyLzFVeWxGbHg3ejhFTGdVMi93TXV4cnIvUnpkMXFOSUFOMWUzS1py?=
 =?iso-2022-jp?B?VXJNeUNuUWtOYzgwVDJTbEdIY1VYQUREanFLOWI4TFNwQ3MrOHNtQito?=
 =?iso-2022-jp?B?VS9OZHZ3WTZrV004azE5NnhMYUJzT25JM3VVOEhNMHVJWS9IMDdGbEp0?=
 =?iso-2022-jp?B?M1JFT2kxZjMyOGZia2VOTDlHeFZJWHNRdGUxM1A2eEc2SWdoU1lQTE5B?=
 =?iso-2022-jp?B?NFhNK3dNSEt2eFBaU1FweUxybm1uejN1L0FFTFBYNDl5cUNEdUcwQ256?=
 =?iso-2022-jp?B?NXJzajJRQmE2Q3pzcHJFWW96SmcySTdHN3c9PQ==?=
Content-Type: multipart/mixed;
	boundary="_004_OS3PR01MB6103AC4F03F328776A6DFBCBC2592OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a61309c4-e9cf-4bab-f442-08dd02d07231
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 04:14:04.8325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CX5RirTw4kW1BAlF3ZIAF6pQkQnsvg//18D3wxkyDyrH+wNmo18veuySNGMBXqZ3ZHWc4Y84WaIV6J64ZL/ye+u6idTm+lwe54eQcdCYoZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13546
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Nov 2024 04:14:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17237

--_004_OS3PR01MB6103AC4F03F328776A6DFBCBC2592OS3PR01MB6103jpnp_
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB6103AC4F03F328776A6DFBCBC2592OS3PR01MB6103jpnp_"

--_000_OS3PR01MB6103AC4F03F328776A6DFBCBC2592OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Chris,

Hope you are doing well.

Regarding IEC 62443-4-2 certification, the certification body has asked for=
 Kernel and IEC test results on M-COM device. Based on my current knowldege=
, I believe that the test suites mentioned here https://gitlab.com/cip-proj=
ect/cip-testing/linux-cip-ci/-/blob/master/submit_tests.sh?ref_type=3Dheads=
#L55 shall run for every updated kernel image on different CIP reference ha=
rdware in LAVA.

Since availability of M-COM device on CIP LAVA Lab still needs some time, w=
e are manually running each test suite i.e SMC, Smoke, LTP etc. from https:=
//github.com/kernelci/test-definitions

There are no issues with running SMC, Smoke tests but while running LTP tes=
ts it is trying to install some dependency packages to the root file system=
. Currently it shows it is a network issue but even if it gets resolved, th=
e packages cannot be installed because the security image has read-only roo=
t file system.

Another idea which needs to be discussed is, since Kernel tests by name mea=
ns focusing on testing only the Kernel, we can try to use a different root =
file system to run these tests. But this is just an idea, this needs to int=
ernally be discussed within SWG and with Certification body.

I request you to provide any suggestions regarding the attached LTP issues.

Thanks and regards,
Sai Ashrith (T S I P)

--_000_OS3PR01MB6103AC4F03F328776A6DFBCBC2592OS3PR01MB6103jpnp_
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
Hello Chris,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hope you are doing&nbsp;well.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Regarding IEC 62443-4-2 certification, the certification body has asked for=
 Kernel and IEC test results on M-COM device. Based on my current knowldege=
, I believe that the test suites mentioned here
<a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-/blob/m=
aster/submit_tests.sh?ref_type=3Dheads#L55" id=3D"LPlnk500022">
https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-/blob/master/submi=
t_tests.sh?ref_type=3Dheads#L55</a>&nbsp;shall run for every updated kernel=
 image on different CIP reference hardware in LAVA.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Since availability of M-COM device on CIP LAVA Lab still needs some time, w=
e are manually running each test suite i.e SMC, Smoke, LTP etc. from
<a href=3D"https://github.com/kernelci/test-definitions" id=3D"LPlnk743732"=
>https://github.com/kernelci/test-definitions</a></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
There are no issues with running SMC, Smoke tests but while running LTP tes=
ts it is trying to install some dependency packages to the root file system=
. Currently it shows it is a network issue but even if it gets resolved, th=
e packages cannot be installed because
 the security image has read-only root file system.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Another idea which needs to be discussed is, since Kernel tests by name mea=
ns focusing on testing only the Kernel, we can try to use a different root =
file system to run these tests. But this is just an idea, this needs to int=
ernally be discussed within SWG
 and with Certification body.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I request you to provide any suggestions regarding the attached LTP issues.=
</div>
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
Sai Ashrith (T S I P)</div>
</body>
</html>

--_000_OS3PR01MB6103AC4F03F328776A6DFBCBC2592OS3PR01MB6103jpnp_--

--_004_OS3PR01MB6103AC4F03F328776A6DFBCBC2592OS3PR01MB6103jpnp_
Content-Type: text/plain; name="LTP_test_issue.txt"
Content-Description: LTP_test_issue.txt
Content-Disposition: attachment; filename="LTP_test_issue.txt"; size=10490;
	creation-date="Tue, 12 Nov 2024 04:07:20 GMT";
	modification-date="Tue, 12 Nov 2024 04:07:47 GMT"
Content-Transfer-Encoding: base64

cm9vdEBkZW1vOi9ob21lL3Rlc3QvdGVzdC1kZWZpbml0aW9ucy9hdXRvbWF0ZWQvbGludXgvbHRw
IyAuL2x0cC5zaA0KKyAuIC4uLy4uL2xpYi9zaC10ZXN0LWxpYg0KKysgTEFORz1DDQorKyBleHBv
cnQgTEFORw0KKysgZXhwb3J0IFBBVEg9L3Vzci9sb2NhbC9zYmluOi91c3IvbG9jYWwvYmluOi91
c3Ivc2JpbjovdXNyL2Jpbjovc2JpbjovYmluOi9zYmluOi91c3Ivc2JpbjovdXNyL2xvY2FsL3Ni
aW4NCisrIFBBVEg9L3Vzci9sb2NhbC9zYmluOi91c3IvbG9jYWwvYmluOi91c3Ivc2JpbjovdXNy
L2Jpbjovc2JpbjovYmluOi9zYmluOi91c3Ivc2JpbjovdXNyL2xvY2FsL3NiaW4NCisrIGtlcm5l
bF9jb25maWc9DQorKyBwd2QNCisgT1VUUFVUPS9ob21lL3Rlc3QvdGVzdC1kZWZpbml0aW9ucy9h
dXRvbWF0ZWQvbGludXgvbHRwL291dHB1dA0KKyBSRVNVTFRfRklMRT0vaG9tZS90ZXN0L3Rlc3Qt
ZGVmaW5pdGlvbnMvYXV0b21hdGVkL2xpbnV4L2x0cC9vdXRwdXQvcmVzdWx0LnR4dA0KKysgcmVh
ZGxpbmsgLWYgLi9sdHAuc2gNCisgU0NSSVBUPS9ob21lL3Rlc3QvdGVzdC1kZWZpbml0aW9ucy9h
dXRvbWF0ZWQvbGludXgvbHRwL2x0cC5zaA0KKysgZGlybmFtZSAvaG9tZS90ZXN0L3Rlc3QtZGVm
aW5pdGlvbnMvYXV0b21hdGVkL2xpbnV4L2x0cC9sdHAuc2gNCisgU0NSSVBUUEFUSD0vaG9tZS90
ZXN0L3Rlc3QtZGVmaW5pdGlvbnMvYXV0b21hdGVkL2xpbnV4L2x0cA0KKyBlY2hvICdTY3JpcHQg
cGF0aCBpczogL2hvbWUvdGVzdC90ZXN0LWRlZmluaXRpb25zL2F1dG9tYXRlZC9saW51eC9sdHAn
DQpTY3JpcHQgcGF0aCBpczogL2hvbWUvdGVzdC90ZXN0LWRlZmluaXRpb25zL2F1dG9tYXRlZC9s
aW51eC9sdHANCisgVFNUX0NNREZJTEVTPQ0KKyBTS0lQRklMRT0NCisgU0tJUEZJTEVfWUFNTD0N
CisgQk9BUkQ9DQorIEJSQU5DSD0NCisgRU5WSVJPTk1FTlQ9DQorIExUUF9WRVJTSU9OPTIwMTgw
OTI2DQorIFRFU1RfUFJPR1JBTT1sdHANCisgVEVTVF9HSVRfVVJMPQ0KKysgcHdkDQorIFRFU1Rf
RElSPS9ob21lL3Rlc3QvdGVzdC1kZWZpbml0aW9ucy9hdXRvbWF0ZWQvbGludXgvbHRwL2x0cA0K
KyBCVUlMRF9GUk9NX1RBUj1mYWxzZQ0KKyBTSEFSRF9OVU1CRVI9MQ0KKyBTSEFSRF9JTkRFWD0x
DQorIFJVTk5FUj0NCisgTFRQX1RNUERJUj0vbHRwLXRtcA0KKyBMVFBfSU5TVEFMTF9QQVRIPS9v
cHQvbHRwDQorIGdldG9wdHMgTTpUOlM6YjpkOmc6ZTppOnM6djpSOnI6dTpwOnQ6YzpuOiBhcmcN
CisgVEVTVF9UQVJGSUxFPWh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRw
L3JlbGVhc2VzL2Rvd25sb2FkLzIwMTgwOTI2L2x0cC1mdWxsLTIwMTgwOTI2LnRhci54eg0KKyAn
WycgLW4gJycgJ10nDQorIGNoZWNrX3Jvb3QNCisrIGlkIC1ydQ0KKyAnWycgMCAtZXEgMCAnXScN
CisgcmV0dXJuIDANCisgY3JlYXRlX291dF9kaXIgL2hvbWUvdGVzdC90ZXN0LWRlZmluaXRpb25z
L2F1dG9tYXRlZC9saW51eC9sdHAvb3V0cHV0DQorICdbJyAteiAvaG9tZS90ZXN0L3Rlc3QtZGVm
aW5pdGlvbnMvYXV0b21hdGVkL2xpbnV4L2x0cC9vdXRwdXQgJ10nDQorIGxvY2FsIE9VVFBVVD0v
aG9tZS90ZXN0L3Rlc3QtZGVmaW5pdGlvbnMvYXV0b21hdGVkL2xpbnV4L2x0cC9vdXRwdXQNCisg
J1snIC1kIC9ob21lL3Rlc3QvdGVzdC1kZWZpbml0aW9ucy9hdXRvbWF0ZWQvbGludXgvbHRwL291
dHB1dCAnXScNCisgbWtkaXIgLXAgL2hvbWUvdGVzdC90ZXN0LWRlZmluaXRpb25zL2F1dG9tYXRl
ZC9saW51eC9sdHAvb3V0cHV0DQorICdbJyAtZCAvaG9tZS90ZXN0L3Rlc3QtZGVmaW5pdGlvbnMv
YXV0b21hdGVkL2xpbnV4L2x0cC9vdXRwdXQgJ10nDQorIGluZm9fbXNnICdBYm91dCB0byBydW4g
bHRwIHRlc3QuLi4nDQorIGxvY2FsICdtc2c9QWJvdXQgdG8gcnVuIGx0cCB0ZXN0Li4uJw0KKyAn
WycgLXogJ0Fib3V0IHRvIHJ1biBsdHAgdGVzdC4uLicgJ10nDQorIHByaW50ZiAnSU5GTzogJXNc
bicgJ0Fib3V0IHRvIHJ1biBsdHAgdGVzdC4uLicNCklORk86IEFib3V0IHRvIHJ1biBsdHAgdGVz
dC4uLg0KKyBpbmZvX21zZyAnT3V0cHV0IGRpcmVjdG9yeTogL2hvbWUvdGVzdC90ZXN0LWRlZmlu
aXRpb25zL2F1dG9tYXRlZC9saW51eC9sdHAvb3V0cHV0Jw0KKyBsb2NhbCAnbXNnPU91dHB1dCBk
aXJlY3Rvcnk6IC9ob21lL3Rlc3QvdGVzdC1kZWZpbml0aW9ucy9hdXRvbWF0ZWQvbGludXgvbHRw
L291dHB1dCcNCisgJ1snIC16ICdPdXRwdXQgZGlyZWN0b3J5OiAvaG9tZS90ZXN0L3Rlc3QtZGVm
aW5pdGlvbnMvYXV0b21hdGVkL2xpbnV4L2x0cC9vdXRwdXQnICddJw0KKyBwcmludGYgJ0lORk86
ICVzXG4nICdPdXRwdXQgZGlyZWN0b3J5OiAvaG9tZS90ZXN0L3Rlc3QtZGVmaW5pdGlvbnMvYXV0
b21hdGVkL2xpbnV4L2x0cC9vdXRwdXQnDQpJTkZPOiBPdXRwdXQgZGlyZWN0b3J5OiAvaG9tZS90
ZXN0L3Rlc3QtZGVmaW5pdGlvbnMvYXV0b21hdGVkL2xpbnV4L2x0cC9vdXRwdXQNCisgJ1snICcn
ID0gdHJ1ZSAnXScNCisgJ1snICcnID0gVHJ1ZSAnXScNCisgaW5zdGFsbA0KKyBkaXN0PQ0KKyBk
aXN0X25hbWUNCisgJ1snIC1mIC9ldGMvb3MtcmVsZWFzZSAnXScNCisrIC4gL2V0Yy9vcy1yZWxl
YXNlDQorKysgUFJFVFRZX05BTUU9J0RlYmlhbiBHTlUvTGludXggMTIgKGJvb2t3b3JtKScNCisr
KyBOQU1FPSdEZWJpYW4gR05VL0xpbnV4Jw0KKysrIFZFUlNJT05fSUQ9MTINCisrKyBWRVJTSU9O
PScxMiAoYm9va3dvcm0pJw0KKysrIFZFUlNJT05fQ09ERU5BTUU9Ym9va3dvcm0NCisrKyBJRD1k
ZWJpYW4NCisrKyBIT01FX1VSTD1odHRwczovL3d3dy5kZWJpYW4ub3JnLw0KKysrIFNVUFBPUlRf
VVJMPWh0dHBzOi8vd3d3LmRlYmlhbi5vcmcvc3VwcG9ydA0KKysrIEJVR19SRVBPUlRfVVJMPWh0
dHBzOi8vYnVncy5kZWJpYW4ub3JnLw0KKysrIEJVSUxEX0lEPXYxLjQtMzQtZzIyMzQ2YzUtZGly
dHkNCisrKyBWQVJJQU5UPSdDSVAgQ29yZSBpbWFnZSBpbmNsdWRpbmcgc2VjdXJpdHkgcGFja2Fn
ZXMnDQorKysgVkFSSUFOVF9WRVJTSU9OPTEuMA0KKysrIElNQUdFX1VVSUQ9ZGNmM2E4Y2UtNDAy
YS00ZTMxLWI5ZTAtNjg4YWFlOTFmYjY0DQorKyBlY2hvIGRlYmlhbg0KKyBkaXN0PWRlYmlhbg0K
KysgdHIgJ1s6dXBwZXI6XScgJ1s6bG93ZXI6XScNCisrIGVjaG8gZGViaWFuDQorIGRpc3Q9ZGVi
aWFuDQorIGNhc2UgIiR7ZGlzdH0iIGluDQorIGNhc2UgIiR7ZGlzdH0iIGluDQorIFtbIC1uICcn
IF1dDQorIHBrZ3M9JyB4ei11dGlscyBmbGV4IGJpc29uIGJ1aWxkLWVzc2VudGlhbCB3Z2V0IGN1
cmwgbmV0LXRvb2xzIHF1b3RhIGdlbmlzb2ltYWdlIHN1ZG8gbGliYWlvLWRldiBsaWJhdHRyMS1k
ZXYgbGliY2FwLWRldiBleHBlY3QgYXV0b21ha2UgYWNsIGF1dG90b29scy1kZXYgYXV0b2NvbmYg
bTQgcGtnY29uZicNCisgaW5zdGFsbF9kZXBzICcgeHotdXRpbHMgZmxleCBiaXNvbiBidWlsZC1l
c3NlbnRpYWwgd2dldCBjdXJsIG5ldC10b29scyBxdW90YSBnZW5pc29pbWFnZSBzdWRvIGxpYmFp
by1kZXYgbGliYXR0cjEtZGV2IGxpYmNhcC1kZXYgZXhwZWN0IGF1dG9tYWtlIGFjbCBhdXRvdG9v
bHMtZGV2IGF1dG9jb25mIG00IHBrZ2NvbmYnICcnDQorIGxvY2FsICdwa2dzPSB4ei11dGlscyBm
bGV4IGJpc29uIGJ1aWxkLWVzc2VudGlhbCB3Z2V0IGN1cmwgbmV0LXRvb2xzIHF1b3RhIGdlbmlz
b2ltYWdlIHN1ZG8gbGliYWlvLWRldiBsaWJhdHRyMS1kZXYgbGliY2FwLWRldiBleHBlY3QgYXV0
b21ha2UgYWNsIGF1dG90b29scy1kZXYgYXV0b2NvbmYgbTQgcGtnY29uZicNCisgJ1snIC16ICcg
eHotdXRpbHMgZmxleCBiaXNvbiBidWlsZC1lc3NlbnRpYWwgd2dldCBjdXJsIG5ldC10b29scyBx
dW90YSBnZW5pc29pbWFnZSBzdWRvIGxpYmFpby1kZXYgbGliYXR0cjEtZGV2IGxpYmNhcC1kZXYg
ZXhwZWN0IGF1dG9tYWtlIGFjbCBhdXRvdG9vbHMtZGV2IGF1dG9jb25mIG00IHBrZ2NvbmYnICdd
Jw0KKyBsb2NhbCBza2lwX2luc3RhbGw9ZmFsc2UNCisgJ1snIGZhbHNlID0gVHJ1ZSAnXScNCisg
J1snIGZhbHNlID0gdHJ1ZSAnXScNCisgY2hlY2tfcm9vdA0KKysgaWQgLXJ1DQorICdbJyAwIC1l
cSAwICddJw0KKyByZXR1cm4gMA0KKyBpbmZvX21zZyAnSW5zdGFsbGluZyAgeHotdXRpbHMgZmxl
eCBiaXNvbiBidWlsZC1lc3NlbnRpYWwgd2dldCBjdXJsIG5ldC10b29scyBxdW90YSBnZW5pc29p
bWFnZSBzdWRvIGxpYmFpby1kZXYgbGliYXR0cjEtZGV2IGxpYmNhcC1kZXYgZXhwZWN0IGF1dG9t
YWtlIGFjbCBhdXRvdG9vbHMtZGV2IGF1dG9jb25mIG00IHBrZ2NvbmYnDQorIGxvY2FsICdtc2c9
SW5zdGFsbGluZyAgeHotdXRpbHMgZmxleCBiaXNvbiBidWlsZC1lc3NlbnRpYWwgd2dldCBjdXJs
IG5ldC10b29scyBxdW90YSBnZW5pc29pbWFnZSBzdWRvIGxpYmFpby1kZXYgbGliYXR0cjEtZGV2
IGxpYmNhcC1kZXYgZXhwZWN0IGF1dG9tYWtlIGFjbCBhdXRvdG9vbHMtZGV2IGF1dG9jb25mIG00
IHBrZ2NvbmYnDQorICdbJyAteiAnSW5zdGFsbGluZyAgeHotdXRpbHMgZmxleCBiaXNvbiBidWls
ZC1lc3NlbnRpYWwgd2dldCBjdXJsIG5ldC10b29scyBxdW90YSBnZW5pc29pbWFnZSBzdWRvIGxp
YmFpby1kZXYgbGliYXR0cjEtZGV2IGxpYmNhcC1kZXYgZXhwZWN0IGF1dG9tYWtlIGFjbCBhdXRv
dG9vbHMtZGV2IGF1dG9jb25mIG00IHBrZ2NvbmYnICddJw0KKyBwcmludGYgJ0lORk86ICVzXG4n
ICdJbnN0YWxsaW5nICB4ei11dGlscyBmbGV4IGJpc29uIGJ1aWxkLWVzc2VudGlhbCB3Z2V0IGN1
cmwgbmV0LXRvb2xzIHF1b3RhIGdlbmlzb2ltYWdlIHN1ZG8gbGliYWlvLWRldiBsaWJhdHRyMS1k
ZXYgbGliY2FwLWRldiBleHBlY3QgYXV0b21ha2UgYWNsIGF1dG90b29scy1kZXYgYXV0b2NvbmYg
bTQgcGtnY29uZicNCklORk86IEluc3RhbGxpbmcgIHh6LXV0aWxzIGZsZXggYmlzb24gYnVpbGQt
ZXNzZW50aWFsIHdnZXQgY3VybCBuZXQtdG9vbHMgcXVvdGEgZ2VuaXNvaW1hZ2Ugc3VkbyBsaWJh
aW8tZGV2IGxpYmF0dHIxLWRldiBsaWJjYXAtZGV2IGV4cGVjdCBhdXRvbWFrZSBhY2wgYXV0b3Rv
b2xzLWRldiBhdXRvY29uZiBtNCBwa2djb25mDQorIGRpc3RfbmFtZQ0KKyAnWycgLWYgL2V0Yy9v
cy1yZWxlYXNlICddJw0KKysgLiAvZXRjL29zLXJlbGVhc2UNCisrKyBQUkVUVFlfTkFNRT0nRGVi
aWFuIEdOVS9MaW51eCAxMiAoYm9va3dvcm0pJw0KKysrIE5BTUU9J0RlYmlhbiBHTlUvTGludXgn
DQorKysgVkVSU0lPTl9JRD0xMg0KKysrIFZFUlNJT049JzEyIChib29rd29ybSknDQorKysgVkVS
U0lPTl9DT0RFTkFNRT1ib29rd29ybQ0KKysrIElEPWRlYmlhbg0KKysrIEhPTUVfVVJMPWh0dHBz
Oi8vd3d3LmRlYmlhbi5vcmcvDQorKysgU1VQUE9SVF9VUkw9aHR0cHM6Ly93d3cuZGViaWFuLm9y
Zy9zdXBwb3J0DQorKysgQlVHX1JFUE9SVF9VUkw9aHR0cHM6Ly9idWdzLmRlYmlhbi5vcmcvDQor
KysgQlVJTERfSUQ9djEuNC0zNC1nMjIzNDZjNS1kaXJ0eQ0KKysrIFZBUklBTlQ9J0NJUCBDb3Jl
IGltYWdlIGluY2x1ZGluZyBzZWN1cml0eSBwYWNrYWdlcycNCisrKyBWQVJJQU5UX1ZFUlNJT049
MS4wDQorKysgSU1BR0VfVVVJRD1kY2YzYThjZS00MDJhLTRlMzEtYjllMC02ODhhYWU5MWZiNjQN
CisrIGVjaG8gZGViaWFuDQorIGRpc3Q9ZGViaWFuDQorKyBlY2hvIGRlYmlhbg0KKysgdHIgJ1s6
dXBwZXI6XScgJ1s6bG93ZXI6XScNCisgZGlzdD1kZWJpYW4NCisgY2FzZSAiJHtkaXN0fSIgaW4N
CisgY2FzZSAiJHtkaXN0fSIgaW4NCisgbGFzdF9hcHRfdGltZT0vdG1wL2FwdC1nZXQtdXBkYXRl
ZC5sYXN0DQorIGFwdF9jYWNoZV90aW1lPTIxNjAwDQorICdbJyAnIScgLWUgL3RtcC9hcHQtZ2V0
LXVwZGF0ZWQubGFzdCAnXScNCisgREVCSUFOX0ZST05URU5EPW5vbmludGVyYWN0aXZlDQorIGFw
dC1nZXQgdXBkYXRlIC1xIC15DQpJZ246MSBodHRwOi8vZGViLmRlYmlhbi5vcmcvZGViaWFuIGJv
b2t3b3JtIEluUmVsZWFzZQ0KSWduOjIgaHR0cDovL2RlYi5kZWJpYW4ub3JnL2RlYmlhbi1zZWN1
cml0eSBib29rd29ybS1zZWN1cml0eSBJblJlbGVhc2UNCklnbjozIGh0dHA6Ly9kZWIuZGViaWFu
Lm9yZy9kZWJpYW4gYm9va3dvcm0tdXBkYXRlcyBJblJlbGVhc2UNCklnbjoxIGh0dHA6Ly9kZWIu
ZGViaWFuLm9yZy9kZWJpYW4gYm9va3dvcm0gSW5SZWxlYXNlDQpJZ246MiBodHRwOi8vZGViLmRl
Ymlhbi5vcmcvZGViaWFuLXNlY3VyaXR5IGJvb2t3b3JtLXNlY3VyaXR5IEluUmVsZWFzZQ0KSWdu
OjMgaHR0cDovL2RlYi5kZWJpYW4ub3JnL2RlYmlhbiBib29rd29ybS11cGRhdGVzIEluUmVsZWFz
ZQ0KSWduOjEgaHR0cDovL2RlYi5kZWJpYW4ub3JnL2RlYmlhbiBib29rd29ybSBJblJlbGVhc2UN
CklnbjoyIGh0dHA6Ly9kZWIuZGViaWFuLm9yZy9kZWJpYW4tc2VjdXJpdHkgYm9va3dvcm0tc2Vj
dXJpdHkgSW5SZWxlYXNlDQpJZ246MyBodHRwOi8vZGViLmRlYmlhbi5vcmcvZGViaWFuIGJvb2t3
b3JtLXVwZGF0ZXMgSW5SZWxlYXNlDQpFcnI6MSBodHRwOi8vZGViLmRlYmlhbi5vcmcvZGViaWFu
IGJvb2t3b3JtIEluUmVsZWFzZQ0KICBDb3VsZCBub3QgY29ubmVjdCB0byBkZWIuZGViaWFuLm9y
Zzo4MCAoMmEwNDo0ZTQyOjo2NDQpLiAtIGNvbm5lY3QgKDEwMTogTmV0d29yayBpcyB1bnJlYWNo
YWJsZSkgQ291bGQgbm90IGNvbm5lY3QgdG8gZGViLmRlYmlhbi5vcmc6ODAgKDJhMDQ6NGU0Mjoy
MDA6OjY0NCkuIC0gY29ubmVjdCAoMTAxOiBOZXR3b3JrIGlzIHVucmVhY2hhYmxlKSBDb3VsZCBu
b3QgY29ubmVjdCB0byBkZWIuZGViaWFuLm9yZzo4MCAoMmEwNDo0ZTQyOjQwMDo6NjQ0KS4gLSBj
b25uZWN0ICgxMDE6IE5ldHdvcmsgaXMgdW5yZWFjaGFibGUpIENvdWxkIG5vdCBjb25uZWN0IHRv
IGRlYi5kZWJpYW4ub3JnOjgwICgyYTA0OjRlNDI6NjAwOjo2NDQpLiAtIGNvbm5lY3QgKDEwMTog
TmV0d29yayBpcyB1bnJlYWNoYWJsZSkgQ291bGQgbm90IGNvbm5lY3QgdG8gZGViLmRlYmlhbi5v
cmc6ODAgKDE1MS4xMDEuMi4xMzIpLCBjb25uZWN0aW9uIHRpbWVkIG91dCBDb3VsZCBub3QgY29u
bmVjdCB0byBkZWIuZGViaWFuLm9yZzo4MCAoMTUxLjEwMS42Ni4xMzIpLCBjb25uZWN0aW9uIHRp
bWVkIG91dCBDb3VsZCBub3QgY29ubmVjdCB0byBkZWIuZGViaWFuLm9yZzo4MCAoMTUxLjEwMS4x
MzAuMTMyKSwgY29ubmVjdGlvbiB0aW1lZCBvdXQgQ291bGQgbm90IGNvbm5lY3QgdG8gZGViLmRl
Ymlhbi5vcmc6ODAgKDE1MS4xMDEuMTk0LjEzMiksIGNvbm5lY3Rpb24gdGltZWQgb3V0DQpFcnI6
MiBodHRwOi8vZGViLmRlYmlhbi5vcmcvZGViaWFuLXNlY3VyaXR5IGJvb2t3b3JtLXNlY3VyaXR5
IEluUmVsZWFzZQ0KICBVbmFibGUgdG8gY29ubmVjdCB0byBkZWIuZGViaWFuLm9yZzo4MDoNCkVy
cjozIGh0dHA6Ly9kZWIuZGViaWFuLm9yZy9kZWJpYW4gYm9va3dvcm0tdXBkYXRlcyBJblJlbGVh
c2UNCiAgVW5hYmxlIHRvIGNvbm5lY3QgdG8gZGViLmRlYmlhbi5vcmc6ODA6DQpSZWFkaW5nIHBh
Y2thZ2UgbGlzdHMuLi4NClc6IEZhaWxlZCB0byBmZXRjaCBodHRwOi8vZGViLmRlYmlhbi5vcmcv
ZGViaWFuL2Rpc3RzL2Jvb2t3b3JtL0luUmVsZWFzZSAgQ291bGQgbm90IGNvbm5lY3QgdG8gZGVi
LmRlYmlhbi5vcmc6ODAgKDJhMDQ6NGU0Mjo6NjQ0KS4gLSBjb25uZWN0ICgxMDE6IE5ldHdvcmsg
aXMgdW5yZWFjaGFibGUpIENvdWxkIG5vdCBjb25uZWN0IHRvIGRlYi5kZWJpYW4ub3JnOjgwICgy
YTA0OjRlNDI6MjAwOjo2NDQpLiAtIGNvbm5lY3QgKDEwMTogTmV0d29yayBpcyB1bnJlYWNoYWJs
ZSkgQ291bGQgbm90IGNvbm5lY3QgdG8gZGViLmRlYmlhbi5vcmc6ODAgKDJhMDQ6NGU0Mjo0MDA6
OjY0NCkuIC0gY29ubmVjdCAoMTAxOiBOZXR3b3JrIGlzIHVucmVhY2hhYmxlKSBDb3VsZCBub3Qg
Y29ubmVjdCB0byBkZWIuZGViaWFuLm9yZzo4MCAoMmEwNDo0ZTQyOjYwMDo6NjQ0KS4gLSBjb25u
ZWN0ICgxMDE6IE5ldHdvcmsgaXMgdW5yZWFjaGFibGUpIENvdWxkIG5vdCBjb25uZWN0IHRvIGRl
Yi5kZWJpYW4ub3JnOjgwICgxNTEuMTAxLjIuMTMyKSwgY29ubmVjdGlvbiB0aW1lZCBvdXQgQ291
bGQgbm90IGNvbm5lY3QgdG8gZGViLmRlYmlhbi5vcmc6ODAgKDE1MS4xMDEuNjYuMTMyKSwgY29u
bmVjdGlvbiB0aW1lZCBvdXQgQ291bGQgbm90IGNvbm5lY3QgdG8gZGViLmRlYmlhbi5vcmc6ODAg
KDE1MS4xMDEuMTMwLjEzMiksIGNvbm5lY3Rpb24gdGltZWQgb3V0IENvdWxkIG5vdCBjb25uZWN0
IHRvIGRlYi5kZWJpYW4ub3JnOjgwICgxNTEuMTAxLjE5NC4xMzIpLCBjb25uZWN0aW9uIHRpbWVk
IG91dA0KVzogRmFpbGVkIHRvIGZldGNoIGh0dHA6Ly9kZWIuZGViaWFuLm9yZy9kZWJpYW4tc2Vj
dXJpdHkvZGlzdHMvYm9va3dvcm0tc2VjdXJpdHkvSW5SZWxlYXNlICBVbmFibGUgdG8gY29ubmVj
dCB0byBkZWIuZGViaWFuLm9yZzo4MDoNClc6IEZhaWxlZCB0byBmZXRjaCBodHRwOi8vZGViLmRl
Ymlhbi5vcmcvZGViaWFuL2Rpc3RzL2Jvb2t3b3JtLXVwZGF0ZXMvSW5SZWxlYXNlICBVbmFibGUg
dG8gY29ubmVjdCB0byBkZWIuZGViaWFuLm9yZzo4MDoNClc6IFNvbWUgaW5kZXggZmlsZXMgZmFp
bGVkIHRvIGRvd25sb2FkLiBUaGV5IGhhdmUgYmVlbiBpZ25vcmVkLCBvciBvbGQgb25lcyB1c2Vk
IGluc3RlYWQuDQorIHRvdWNoIC90bXAvYXB0LWdldC11cGRhdGVkLmxhc3QNCisgREVCSUFOX0ZS
T05URU5EPW5vbmludGVyYWN0aXZlDQorIGFwdC1nZXQgaW5zdGFsbCAtcSAteSB4ei11dGlscyBm
bGV4IGJpc29uIGJ1aWxkLWVzc2VudGlhbCB3Z2V0IGN1cmwgbmV0LXRvb2xzIHF1b3RhIGdlbmlz
b2ltYWdlIHN1ZG8gbGliYWlvLWRldiBsaWJhdHRyMS1kZXYgbGliY2FwLWRldiBleHBlY3QgYXV0
b21ha2UgYWNsIGF1dG90b29scy1kZXYgYXV0b2NvbmYgbTQgcGtnY29uZg0KUmVhZGluZyBwYWNr
YWdlIGxpc3RzLi4uDQpCdWlsZGluZyBkZXBlbmRlbmN5IHRyZWUuLi4NClBhY2thZ2UgcXVvdGEg
aXMgbm90IGF2YWlsYWJsZSwgYnV0IGlzIHJlZmVycmVkIHRvIGJ5IGFub3RoZXIgcGFja2FnZS4N
ClRoaXMgbWF5IG1lYW4gdGhhdCB0aGUgcGFja2FnZSBpcyBtaXNzaW5nLCBoYXMgYmVlbiBvYnNv
bGV0ZWQsIG9yDQppcyBvbmx5IGF2YWlsYWJsZSBmcm9tIGFub3RoZXIgc291cmNlDQoNClBhY2th
Z2UgeHotdXRpbHMgaXMgbm90IGF2YWlsYWJsZSwgYnV0IGlzIHJlZmVycmVkIHRvIGJ5IGFub3Ro
ZXIgcGFja2FnZS4NClRoaXMgbWF5IG1lYW4gdGhhdCB0aGUgcGFja2FnZSBpcyBtaXNzaW5nLCBo
YXMgYmVlbiBvYnNvbGV0ZWQsIG9yDQppcyBvbmx5IGF2YWlsYWJsZSBmcm9tIGFub3RoZXIgc291
cmNlDQoNClc6IE5vdCB1c2luZyBsb2NraW5nIGZvciByZWFkIG9ubHkgbG9jayBmaWxlIC92YXIv
bGliL2Rwa2cvbG9jay1mcm9udGVuZA0KVzogTm90IHVzaW5nIGxvY2tpbmcgZm9yIHJlYWQgb25s
eSBsb2NrIGZpbGUgL3Zhci9saWIvZHBrZy9sb2NrDQpFOiBQYWNrYWdlICd4ei11dGlscycgaGFz
IG5vIGluc3RhbGxhdGlvbiBjYW5kaWRhdGUNCkU6IFVuYWJsZSB0byBsb2NhdGUgcGFja2FnZSBm
bGV4DQpFOiBVbmFibGUgdG8gbG9jYXRlIHBhY2thZ2UgYmlzb24NCkU6IFVuYWJsZSB0byBsb2Nh
dGUgcGFja2FnZSBidWlsZC1lc3NlbnRpYWwNCkU6IFVuYWJsZSB0byBsb2NhdGUgcGFja2FnZSB3
Z2V0DQpFOiBVbmFibGUgdG8gbG9jYXRlIHBhY2thZ2UgY3VybA0KRTogUGFja2FnZSAncXVvdGEn
IGhhcyBubyBpbnN0YWxsYXRpb24gY2FuZGlkYXRlDQpFOiBVbmFibGUgdG8gbG9jYXRlIHBhY2th
Z2UgZ2VuaXNvaW1hZ2UNCkU6IFVuYWJsZSB0byBsb2NhdGUgcGFja2FnZSBsaWJhaW8tZGV2DQpF
OiBVbmFibGUgdG8gbG9jYXRlIHBhY2thZ2UgbGliYXR0cjEtZGV2DQpFOiBVbmFibGUgdG8gbG9j
YXRlIHBhY2thZ2UgbGliY2FwLWRldg0KRTogVW5hYmxlIHRvIGxvY2F0ZSBwYWNrYWdlIGV4cGVj
dA0KRTogVW5hYmxlIHRvIGxvY2F0ZSBwYWNrYWdlIGF1dG9tYWtlDQpFOiBVbmFibGUgdG8gbG9j
YXRlIHBhY2thZ2UgYXV0b3Rvb2xzLWRldg0KRTogVW5hYmxlIHRvIGxvY2F0ZSBwYWNrYWdlIGF1
dG9jb25mDQpFOiBVbmFibGUgdG8gbG9jYXRlIHBhY2thZ2UgbTQNCkU6IFVuYWJsZSB0byBsb2Nh
dGUgcGFja2FnZSBwa2djb25mDQorICdbJyAxMDAgLW5lIDAgJ10nDQorIGVycm9yX21zZyAnRmFp
bGVkIHRvIGluc3RhbGwgZGVwZW5kZW5jaWVzLCBleGl0aW5nLi4uJw0KKyBsb2NhbCAnbXNnPUZh
aWxlZCB0byBpbnN0YWxsIGRlcGVuZGVuY2llcywgZXhpdGluZy4uLicNCisgJ1snIC16ICdGYWls
ZWQgdG8gaW5zdGFsbCBkZXBlbmRlbmNpZXMsIGV4aXRpbmcuLi4nICddJw0KKyBwcmludGYgJ0VS
Uk9SOiAlc1xuJyAnRmFpbGVkIHRvIGluc3RhbGwgZGVwZW5kZW5jaWVzLCBleGl0aW5nLi4uJw0K
RVJST1I6IEZhaWxlZCB0byBpbnN0YWxsIGRlcGVuZGVuY2llcywgZXhpdGluZy4uLg0KKyBleGl0
IDE=

--_004_OS3PR01MB6103AC4F03F328776A6DFBCBC2592OS3PR01MB6103jpnp_--


