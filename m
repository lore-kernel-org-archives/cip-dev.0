Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1DECA0EFF
	for <webhook@archiver.kernel.org>; Wed, 27 Aug 2025 07:33:10 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.9349.1756279984919915165
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Aug 2025 00:33:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=xlu0VtNG;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1756279977;x=1757489577;bh=V3kmYLMrhNQggfsB4INC9pzP/DC0Py/A7fYF/
	qZpWww=;b=xlu0VtNGnPLcJ36A7YzT9WP2DwmCM+D4yEBXQdSPzE8HW/wUOCsBSVjMNGD5UEhiaFe
	lPOcrfuxVvyHVqmVuLtAVYV1a1qxkMYfPQNpSPGoQ33JsQdB/1qYxpRxJNaf3XQJ+PL04+5O3b3bo
	BX2+cqtc1INsXSRksY6IzVgvPfsx7XUkUd0cPAA/qytsoI9kSuja9U5bnUrzGQDsrlYeBINiqmm+J
	r6KczitVHdIdKTgEB5Iky1ZuktLDzNr8rm1N3gP+Nqfz2VQuSmjX9LiTALGQggWJQiXg0PR5uyJf8
	8sHKzwWRbjdqczPPoIokjuJ2/qhx/UvXzcx8M7ezRd5g==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 57R7Wv5Q2935395; Wed, 27 Aug 2025 16:32:57 +0900
X-Iguazu-Qid: 2yAbj3N9d6G1qtXSYi
X-Iguazu-QSIG: v=2; s=0; t=1756279971; q=2yAbj3N9d6G1qtXSYi; m=QG5t1NzQ+mRx3HBKOdwo7kYRzJMIFTz+/SN3KSeWXu8=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cBbpp4yqKzyPZ; Wed, 27 Aug 2025 16:32:50 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WT2ApQSPeIzf+f/fCN0VF1v2dE5IwzlrYlkmYfaETkRmFoV076bJzRknhf29bmEeJq+Wl/PZmRhI4VjAeMHauiwF+yXXeq7acacUvDr9T5xcvN1KOm9nJlhQ34qigXwik5DKox+aPsQIDXhHxPvrNPD5gMyOBYnH/DV9HA5G9VamnL0E8szkv3+7cAfUBCFYPTWXzXlHoAUWZUPUUOf6r1J5ejE3eEzehncb6gK7cDWoOOOjM3XYnpLOgcr5qLPHDmoIapiZaSK92+U7+Jofh/nUe7HZ9lQPfzU33VOyMj8pVNSyOfK1UsBmMyjaaUxjmptR8Nqp18gLt5wLUKCgsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHvDc+XoRmXUxt1dYuRRqOhNrNA6fM0UkYfyz8wDI/o=;
 b=MQikMevSxrC1uzY4URbo+eExxhneRV8gz547eF3Tw7b8uOx620PGi6HNGWZeGiitBwTh33/BHEc7urblNo5/+FFj1Pt5shL4PcCOPLwha4R3NNcutQ2YuMIDfajDhuZy1Lp/MhZlLE0SbXMohuU7nHxOL1i7uvTw18kL3sBx6GeUwz3SKt9UTeu6gTXR0mGdCjNJOPjN8q1DBW+FVnLgS9NfSHRC765U+eu+yPOLAUpEOulI/T+G4ztFjgs0GcmmrmTp2wxmUyanV8CFbY68tztM5p5rr9DNp+KIIKU5D2TCjWOsQmfETPi5dq9e2GcW1kmAr0R5gBPBVb3bNqVjYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <claudiu.beznea@tuxon.dev>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 6.1.y-cip] arm64: dts: renesas: rzg3s-smarc-som: Fix
 Ethernet aliases
Thread-Topic: [PATCH 6.1.y-cip] arm64: dts: renesas: rzg3s-smarc-som: Fix
 Ethernet aliases
Thread-Index: AQHcFwbUNo8dLKNcCE+DFKIKXfLq2LR2G22Q
Date: Wed, 27 Aug 2025 07:32:48 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818895D45B5E6A30739C66DCD38A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250827035801.568246-1-claudiu.beznea.uj@bp.renesas.com>
 <20250827035801.568246-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250827035801.568246-2-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB7179:EE_
x-ms-office365-filtering-correlation-id: 4d24570f-3700-4d5f-fc41-08dde53bec1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|7053199007;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?ODdUK0JHUEpIcDVGTzN0WmdUempaVjBjYTNURVBYV2xGS3Q5N21nb1hZ?=
 =?iso-2022-jp?B?SzlaRXRnL0VaRnlTcUlEajltc2pVT1c4dExJK3hNVGROaGxOOWxIa0Q2?=
 =?iso-2022-jp?B?U25jNnkyd1g2UTZuNjNleGljTkZYV2NMVmkzcUN4M3Z1akNUb3JpVzQr?=
 =?iso-2022-jp?B?MHpwM04rSVhzYzlWN2k5dXBzd3AydkJIbnZYelNueTlzWUt1eDBsU2hB?=
 =?iso-2022-jp?B?algycnk5dy8yUDJzSFNqNkJWK2JtN0N6SmJ2cm83K3ZCd1ZFNXV2L1dP?=
 =?iso-2022-jp?B?UENZNXNkdDl6cmdTOTJ6OHVWb2phM0hqdEZSVkQwaUk5UEg2dmVBNTBI?=
 =?iso-2022-jp?B?R1NLN0d4dGlxallpY1k3RjA5aUtZVUtUQnVjb01MMEdTOXpBWGh6M0N6?=
 =?iso-2022-jp?B?cUxuc0dIYlZJMEF3STZ4bzJhUHgwUXJvNmhZSy9KZ2dnbzloOFc1VWpm?=
 =?iso-2022-jp?B?YWwxUExjTUcwVjUxb3UyOWRETG50TzBpWjdMTjZBK1FzNGd0Rjl2d0Fv?=
 =?iso-2022-jp?B?M2EvK00xdmtXVjlVaStMNm5pVVpsalZQbTAwaGs4b3RXeWpoaXFsdTNB?=
 =?iso-2022-jp?B?b1pnL3Z5cEV1ZG9oVlV3V0VWdFlDem5MTncycTdHSTc3ZTJMUGo2Skto?=
 =?iso-2022-jp?B?Z014aXltZlV4K0NhaDNvTzlUcXJweWhBWElYM0dXK0YyeThyV2Z2eTR1?=
 =?iso-2022-jp?B?VWZQRmxORktNMlRFbng0SkJpSmR6T1B4YkhhR3ZuVHhjZC9KQllRTTI4?=
 =?iso-2022-jp?B?RW85UHgweG5IcndJWWNsWDJxZEE3SHpmdkNMSVVyWGdKZ051VWtRK1V0?=
 =?iso-2022-jp?B?dzFpZ3pnYTNkS0plaUVEb3EvSmdVNHZ3d05vSW5iK2NQM3o3ZHZsWjlN?=
 =?iso-2022-jp?B?NG5OOGlzNXhRMGpjRWtNeHU3Z3BTcDlkbEI2eXROdS81b0xoQVYwUUFU?=
 =?iso-2022-jp?B?MTBPQkJ0emMzMFEyVkVET2ZCTnF2MVRDN2tEUml3c01EeHhPSFZ4S2Zn?=
 =?iso-2022-jp?B?MVdIZmlFKzRGWVZlelJkK0ZaSGRsTkdFdy9UNU5lQUEwb2NmQUV6Tmwx?=
 =?iso-2022-jp?B?MUw3NlVkTTRxMDJ0aTRuczFydjYrbGJDd0ZtdXpla0tNZmxjMFBRM0ND?=
 =?iso-2022-jp?B?MnNENXBkYXUvT1Qvc2czNVpzRitsUGFDQ0gwU1BHMml6S3QyMmJVa0pH?=
 =?iso-2022-jp?B?SEtWYkZCRE5Ec2llTnFmQ05BUG90OGg0RzhFRDY5VFlTQ28xaGExOWFu?=
 =?iso-2022-jp?B?U25mamJ5QnhkQU9rVFlZblZ1dUhYMHZiTlV6ZlpDdXlkUFNGYzBxck5T?=
 =?iso-2022-jp?B?K1VrRFgvNkhCcE5nL09JZE1IZ1M4aXdVYnJyUDBlbkNYc0ZVVEkxMU9D?=
 =?iso-2022-jp?B?eTZBWGF2dTJoQVlyYnVhZzNpcTVIMGpvVXB3dWE1UTg5RTBkNVpiNTFL?=
 =?iso-2022-jp?B?cWQ5WHFWS0xJdlFXRklxY2ROZXVJVUhYWHBNTzc2aWlXTDhxbzExeTVG?=
 =?iso-2022-jp?B?MHZWTTk0a3dheTczQUdkVGF0MXF0VkNIOHdvUTNCZlNPQVpsR0dhMm8w?=
 =?iso-2022-jp?B?UUordy9sZU5EYmRxV3BHd3F6dU9uZjZZRFFvWWgxRzgzMFlzR2pKNzk0?=
 =?iso-2022-jp?B?N0pmdDhiQVNER25zODdNL3h1QnVkOTM3RDFyc2hTOHRJUWFxdi91cVIr?=
 =?iso-2022-jp?B?aFd1RlluN1BUUXEyQ3NDVmQzUjdYTUswUGVVU2lBS0lkRjNhR1NWS3hR?=
 =?iso-2022-jp?B?ZlJJUlBkQWMwaUdhZldkYVBJTXpaZU5JWHpxYW13bVFzN0ttYnB1V1dr?=
 =?iso-2022-jp?B?YVE3MTdFM2RkeDhuRzMwWDNiRGhjY1d5SWU1eWIya0NKSGFrS1JpQkhC?=
 =?iso-2022-jp?B?d1JJUVliZDgxa2h5WE55cUhSNzJCZ0Zzd2RDZzBsNkJ1bzdqdEo2SWlm?=
 =?iso-2022-jp?B?UUI2cG9sQVU3RkdITml2VXpBNlFQYmdDNC91RnZQTEhCdC80OE1MTzFB?=
 =?iso-2022-jp?B?dk1xUGgrNlJRZWxnN1BEYjFMTGoyNlJIOERsQ2JUdUd1RkFuT2xnTTFP?=
 =?iso-2022-jp?B?a0YycFNFSC8yeTcrMW8vSmZaQ0lpM0R5YlpJTkhHSGR3VUNXSmtkRi9X?=
 =?iso-2022-jp?B?ekI5dk1rZkRrMVdRbFFZUVBtMHZtWWxwa21nL1YwN3E2RysrNUtPTFNE?=
 =?iso-2022-jp?B?bS93PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RWdEN3RxUU45N2k5ejF5T2NxWnU5QzI2cWtNV25PUkw0WTdVZXdXS0Vr?=
 =?iso-2022-jp?B?V0taRFRpZkFtdXRxZnRkY3ZKS05WMlNRelpVTlkraUcyWkU4cWI0WFpx?=
 =?iso-2022-jp?B?NXNvaGdxNzhqYVhLa2prdk95TTI2a1JIWGI0OUthNGJScjJKRy9vaGNX?=
 =?iso-2022-jp?B?M0NCSHcwSE5wSGhrbkNOdEloamVvM3ZaNW0vOEltNlVVOXViRkxYWExl?=
 =?iso-2022-jp?B?TnlkUmRDS0d2aDlpR1FTdDg4dW5hNGhNMFQ1bEc3RUZEcVYxeFhrKzU1?=
 =?iso-2022-jp?B?ZGxFQ0FzTG1pZUhrTFNhZUdvMW9BWnJvbWZIQnlrc21qNVNiSldEaFlB?=
 =?iso-2022-jp?B?aGJVNTZGM0dMVWM2Y0FOQi9OSHlKbXVBd3ZrSExCTkhYY21IeHc3NEky?=
 =?iso-2022-jp?B?ajFybGZkNTkxaHhpOFRWUnpxZDlMZ2ZzZUpsckRtV0xZd3hIdnRncE1X?=
 =?iso-2022-jp?B?TjBFZlNDK1VrWG0wczBvMDJ1MmVUN3Y3SE9WRndCVHBiVFRROFgvOWtQ?=
 =?iso-2022-jp?B?dS95REFYTExJK3QrVXJJaDBQcSt3dkp3T2VYOVZPR1RRTTI2RVJjcis2?=
 =?iso-2022-jp?B?UHMyZVh3QjZDdjM4Ymo3c1FMMnM2ZG03NmxWTGtzZ3lFRm5WTGFvU0pp?=
 =?iso-2022-jp?B?Nm5Qd25qeW9LTkpoVG9xZTdCQ0VjVEZaUTVLMm1ocWVvSlBuZFcwWk1s?=
 =?iso-2022-jp?B?YTM4WGFLaEcrUUZPdHlxbkFEdFg0bkZ2cDByeUFTcXpBd1BSSk84aXZo?=
 =?iso-2022-jp?B?VUFQSTdNK01VM2c5UlNTTmE5RDNxc2YyWU9pa3NRMm9wbEQ2WkJhWVpN?=
 =?iso-2022-jp?B?dmt4TDVzQXA0Q2JMOS92S1VLTTluQjhkWmFoRlU3RmFrKzcwM1hvRnNa?=
 =?iso-2022-jp?B?ekV2Tjd5ZzBCVlJkOUFoejcvV2lhWmF2VGpoNDRxSEZSRlJrRHhzZkwz?=
 =?iso-2022-jp?B?K0FJRmRNcnZhMGxMYTFlMFpGSUhmZ2o0bm9WL29JT1V2Q1Vyd29leGd6?=
 =?iso-2022-jp?B?VDJsNWF3U3JtMzdlaGhYcmRpajJPNjlscVBPTDFFVXFGU1hEbnczU0pj?=
 =?iso-2022-jp?B?ZTlHYklxZDYzazJCRHZLL2w2ZGJsMDdqMmFxcC9Yb09ZRnY3aDJLTk1N?=
 =?iso-2022-jp?B?YlpSbEMzcExWc2cxeWM5TkRLRUxBVHcyUVp3VjJ2ZGNxMVg5NEZsdHpU?=
 =?iso-2022-jp?B?R2FjTTh1OCtJWW53dWYyeDhZYUNTOEIvRTRCcnNSVDVGSlJuRjV0d3Jo?=
 =?iso-2022-jp?B?K3FVMnJMVWMyMVFRYVl4a3duKzc5TUoxdXpkQ0Z0RHF1T1F4VjhwM3Fj?=
 =?iso-2022-jp?B?YVZXNGo1Z0Y2ZU9mSXVFOVdJcVI0VmlSc1BXZFpnc2c0S0RJaHpPR1Zh?=
 =?iso-2022-jp?B?eGU5VDZYWG5xK1FDemRjS1RSaWVsMUx3NnVWTHdiemxCSmVZeFVnK1pS?=
 =?iso-2022-jp?B?TmpzVjRwcGNtaUU0ME45dktEVys4aDVQUDZKTTdYNlpKVE9jaGJjNTZq?=
 =?iso-2022-jp?B?K0MxL2F6eDhycnpnUHIveitjbWFBclNYMnpCeklIaExYNGMyQ3lzWEth?=
 =?iso-2022-jp?B?cktTUVhCWXBKcWFRbiswTW9EZG1RZkgwT29vNFo5UmZmQitWM2Q4Qmpp?=
 =?iso-2022-jp?B?ZHBLeEZBaVNQWk1nK1MrenpJZmo4SVNnSi9hb2thbmlyUjF4cnR3VFpC?=
 =?iso-2022-jp?B?ZkpEQThRcFBwb1c3WWRaVHh2OFZIbzBmQjhoWldMTFNnS2ZtTlZMWlVl?=
 =?iso-2022-jp?B?d1BMZUxCNWtTTFUrT21qSTgyNmE2YzJvcW5qOXpuRUNEcDMvREFleXZw?=
 =?iso-2022-jp?B?VkxrVmd5Vnl2RnlJNkRaWWo3eCtOZUEvY3dqNE53ZDc5MVhuSTdrZWxH?=
 =?iso-2022-jp?B?b3pGK1U2d0w3ZDNsVDdMZ3JhK0x4OWJRME9Cb09JdHFWcXNNRXpuZGlJ?=
 =?iso-2022-jp?B?dFJteTdrS1JyNnB2UFM5ZHJmMG1DbE5GY0czTkhnUFhuL0xxUjJ5Y1NX?=
 =?iso-2022-jp?B?YlZmeTRicUErL2FQd2tCdStmaGdhbXhVUEtKT2NFYytKUnF0cmRQVUoz?=
 =?iso-2022-jp?B?cnZnOXZ0S2xYYkx0K0thc1hydVQxcXErZWR2c1V4UDV3Qnhsc1hQWWhH?=
 =?iso-2022-jp?B?ajhWR1h2UlFSaHJvSHQyL1JYcS9EWkxnV2NhNmVQaktDeTdwM2tndkhK?=
 =?iso-2022-jp?B?RW9ZQUhkbTdJZ3JMclBqeUNyakNVYlJFcENkeS9hNHpiNDE0bnJ6OUdw?=
 =?iso-2022-jp?B?Q0UrcmdIRHg3NTlQT1R5NDlpeVhFK3NqV2xaNnpsaFlkRmgraEhNY2Nt?=
 =?iso-2022-jp?B?QzhEOTJ6U3ZyZHQ0YmlNNE40d09QbEJqUVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d24570f-3700-4d5f-fc41-08dde53bec1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2025 07:32:48.3119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3f4YcQce3k+0HQazr/7rmXEz5OiC27+Q57jpHAYD8TH3pGlwpKr+GtbxpoThrER2QLkHJYdAvf+fsu3vJpCoHIjpr3xmeVpiS5fMeP1zglD8BOsY9O1F3Yl8cJ9cwljE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7179
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Aug 2025 07:33:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19973

Hi all,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: Wednesday, August 27, 2025 12:58 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; pavel@denx.de
> Cc: claudiu.beznea@tuxon.dev; cip-dev@lists.cip-project.org
> Subject: [PATCH 6.1.y-cip] arm64: dts: renesas: rzg3s-smarc-som: Fix
> Ethernet aliases
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> commit be4e4dd8a1994e5730dfdb8dfaf1f2418f8a199d upstream.
>=20
> Fix typos in the Ethernet aliases.  U-Boot uses the ethernetX (X=3D{0, 1,=
 ..., N})
> aliases to update the DTB with the MAC addresses.  The ethernetX or ethX
> aliases are not used by the Linux RAVB driver.
>=20
> Fixes: 932ff0c802c6 ("arm64: dts: renesas: rzg3s-smarc-som: Enable the
> Ethernet interfaces")
> Suggested-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link:
> https://lore.kernel.org/r/20240328065738.3049316-1-claudiu.beznea.uj@bp.r
> enesas.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> index 3f050a28f2a7..3d707c9c6e46 100644
> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> @@ -20,8 +20,8 @@ aliases {
>  #if SW_CONFIG3 =3D=3D SW_OFF
>  		mmc2 =3D &sdhi2;
>  #else
> -		eth0 =3D &eth0;
> -		eth1 =3D &eth1;
> +		ethernet0 =3D &eth0;
> +		ethernet1 =3D &eth1;
>  #endif
>  	};
>=20
Looks good to me.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


