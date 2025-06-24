Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84624C77B7C
	for <webhook@archiver.kernel.org>; Tue, 24 Jun 2025 04:10:45 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.976.1750738241129157847
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 21:10:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=P6+35BR1;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1750738229;x=1751947829;bh=seNmr0VLefQOwDx/sdHI2PKIHAgoBoxKYPgaZEK
	RRuk=;b=P6+35BR1H67ZCiwZ71xtCeUar45f6kYm8FuLYrIQN7PstCW5NDaLbskLr49SlSUERXtqM
	cw6e3v6tZjSf+ogNutWzIXc58Yy4wG+jQbnVkrqdENSdVOdDmQNPdItvcVnDYjCYBHgXmBCaE8De/
	JOgLR6jEzZvsq5eSkt2NN5eb+/apo8wDB2x2xHWkNEvYYbfmY3s61xqM8mIG4qK79+bIntOx7cQJY
	0HuPfGmR/X8t9m60yDXbUNtAe/8lU5YQrousV5YqfKr1UXGJwoTUzfLhI2J+UN8VvqPMbCWdeGWox
	/X+IcMLMXTmfL8oJjgm9AkRJLJUT5IFV5mtmyzLCSw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 55O4AST02540637; Tue, 24 Jun 2025 13:10:28 +0900
X-Iguazu-Qid: 2yAbpfLvIxsOmRf3VC
X-Iguazu-QSIG: v=2; s=0; t=1750738228; q=2yAbpfLvIxsOmRf3VC; m=/qm7zi6ywepMBjuRl3XEsoKcEMvjSEby57W8HkzNdcI=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 55O4ARAP2461117
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 13:10:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I6QRlNl6rh1YqdhAAsgdQ4UdCgRnYFKPr0dfF7ANBROkXYrumYucgPyT+10r+ka5gqdEuAsuk6x3+Yjd4ypul2k6RdL9Pgbt6WJm7r/M7pyL9qpdmGiWXsN1hck6X0dgUd7trU1s5x6J5rsS9hgQkSGSG4SveNEgZQgPz+9CmXMhiv3gHimplq9wZc+za8hrrSRCJzrk0ZUJUl/u6TLZZPxoUL1bFdSsXxD17LxT7nj90K0zqAWtoRsMpCdvxfo5gyxFL4Nz2RiCHCijCIZyF8dJlF7Er6yf4cNHDBE7Y7ENayd89NnVMJUVoAoLIGU3b3f6jwKah/eDPB/pg3wH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OovVA1oD/sJ0nRqZzQqbAn4iEaODwEHJaVpLA7SaKBw=;
 b=y7UH3BbFJruuyYaGZzXoTY7QxnYnEBjvVTSzBlt4KdT6QsNH8+U+nzxUIXaTooShKfT7/41dMCSrMbXLLkqCAlZv4C5woYQL2x6IKrVvGh/HktkeDIMpn4nc0ohWM2UnIlkCQTik/ML5raGQjV8ak+Zowj12uwbMXuTeBR1zWoIYmxfE8gLZH7/HJDvoca9FOXeXnrl/+pv32DWw4k2kGatXxFFXGwguzx5rgMa77vtoJvZMEx4ozvNGyu0szevG/+6szHn7r8om66k1iWGOTihTyyfa5LJN+NiTclJes05/qjxj1Rhh1hZ14hFiBwirzYKjH0IXPvvJBxb51NdzhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <tommaso.merciai.xr@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <tomm.merciai@gmail.com>
Subject: RE: [PATCH 6.12.y-cip 0/7] Add support for RZ/G3E WDT
Thread-Topic: [PATCH 6.12.y-cip 0/7] Add support for RZ/G3E WDT
Thread-Index: AQHb5CmyRf4waXBPokqJIE4BHVKXe7QRsx5A
Date: Tue, 24 Jun 2025 04:10:25 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148181D1AF7D8BD9A7825E9DE9278A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250623102857.1493371-1-tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <20250623102857.1493371-1-tommaso.merciai.xr@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYYPR01MB16361:EE_
x-ms-office365-filtering-correlation-id: 9785afeb-54af-4f48-8414-08ddb2d50bc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?bmVPcEd4WVM2TlpCTW1PVi91YmVJTUJvVUFZUktGV3lJM1JKL01seFl6?=
 =?iso-2022-jp?B?bDRHRVVGME5ubTJxVkVobG9xUkJOTzJ1RmxOQ1E4RDYwTTZuS0ZYaytv?=
 =?iso-2022-jp?B?MFMyNjgySnFQYzI0Rko2ajBSQmM5REN2djNMOUxXNVBKYnlLaUo4aGRh?=
 =?iso-2022-jp?B?QjlmTExsSTRaRmRoNWduS0h4ZDJycFZCWkFJUndmd01Fa1hpeWtDNWhn?=
 =?iso-2022-jp?B?K3hkTDRIZWpCZVh3LzJLQ25iaGxEb0F6WFptZnI2R2hDdGdGRXBRcGNw?=
 =?iso-2022-jp?B?RU9hZmoyNnF2dXBkZnY3d3pRRnlmWVN6emRBdEtXbmxoRkRnVWlXMjBx?=
 =?iso-2022-jp?B?SEtoWDhOZklvTWd4VkNadTRPZzlCSUFVSVVYbFA3SkJsUWRVN1JSQ1dQ?=
 =?iso-2022-jp?B?dEdKemkvaEdGUmdIVUpKWVJubnNHQmh3Z3FsN0RtUnhqOTZtbWYzTVky?=
 =?iso-2022-jp?B?dDRlak8wT05WQWwzOE9FMENGQ0lXK3lEK25CcDRIdkdNMGJqdUViZ0Ri?=
 =?iso-2022-jp?B?WW5URjdyZGFkNnVCeDVLa0g1QjR3ck1GUW5vNzRvYlc2RHVJb0lRdVZK?=
 =?iso-2022-jp?B?K3A0eHFLUHJ1RC9ib3FqVG9CWE85bEJ0RkRROU1DU2loQ0pxRWc3WGZo?=
 =?iso-2022-jp?B?aitjalMwMFVEZGpOYlZ5dWQrazdWQXFDZlpqQW0zd0p1eFkxSERRYkR0?=
 =?iso-2022-jp?B?YWVSbFdNVDhXaWtFUE56Q0ZXbk1YRnNqdUNMd2JIWEJUSVJGaXYwQnpa?=
 =?iso-2022-jp?B?eTFsRHhZSHhDbWwzSnUrdC9MWXJ4dHN1QkhMdDlZVFl0bDZsdzJPVFdB?=
 =?iso-2022-jp?B?RE1wTDhrTERkNEZwYVk5ZFpIYk0xSm5qajJsd2d3UGlmNmtlUmJDU1F2?=
 =?iso-2022-jp?B?ckp0RzdyU0YvYXl5dEx0UXE0NG5ic1NveG1ydVNVK3lCSUErZGNkRkJ0?=
 =?iso-2022-jp?B?amdNdjJOOEhwV3UwNUZ2Y0M5WUVxaFZySzVySkZ5a2tLMmx0QkNsVGZn?=
 =?iso-2022-jp?B?WUZGcjdrbjlldjhZTkN1MWZxbzBteWh6SGdob3dvTElERnBFNllMZUtp?=
 =?iso-2022-jp?B?dWh3TTVyUkpyZ0w0bDVZcFBySUNscFA2aGFsR1djTTdOc0Nyb3JMSUhs?=
 =?iso-2022-jp?B?VnY5QUlkZWhYWk9tVmdEaDMySDE4ci9pR0psRDAyRVl3NjE4eFpqWi9m?=
 =?iso-2022-jp?B?T1ZNdTBhSDlvOEh6L0pIMWl6bTdSVEhaYnJMNzIzWjlqNlFGd1ZLRVFp?=
 =?iso-2022-jp?B?VVB3UGJnL2JxYTJFbDN0akcwNitoT1Y5TzhKUmRHMEgwRjlDemE4dGNQ?=
 =?iso-2022-jp?B?L2Vjd3Vtd3E3ZXViZmg0ajNpL2hmY1drMEsrUXJpZmNhSzlBYVAwYWdU?=
 =?iso-2022-jp?B?d1ordWY2cG1yNk9mbUNQQkpqV0FaVWV3NS9iUWxBNDRwdCtTMGhTcFdP?=
 =?iso-2022-jp?B?WWNqOVh3SUxhSlFzZ3RtN0VEVUxFRG5XQjZOYzl4S0kyZzh6UXZpc2xS?=
 =?iso-2022-jp?B?d2NmZlhST2c4RU5jWmFXdkhXS3gwOU1mOFlSd1NjRGxwWEhXWVdYWG1i?=
 =?iso-2022-jp?B?VzZadSsveFM3UW0rVjVpYTBSaGxyQlpzVzhULys4bnROUnI2OFpnME55?=
 =?iso-2022-jp?B?SkJTbWIvYUtiSzd0TkJoK3dCTTZPQUkwbURyWm9qMTBtYWFVT1E3dk1X?=
 =?iso-2022-jp?B?K0V3cFNaNUxIWWd5VHRlR2pJd2x3UjcyWHFJQUNqQlZOUXJIKytjYkhL?=
 =?iso-2022-jp?B?VFQ2UkNKVU9ySUU2bVJJZmNlalZydUpDTitlRjNBVzd4Z2Y1bHk5STVB?=
 =?iso-2022-jp?B?MzdHeVhadFFBZ3M1M2EwSUxWUG80Q1J0OTJ1T2NHM0JRbk8xMkdTNkM2?=
 =?iso-2022-jp?B?dXpUWFRRem1PWXBoTXRxdWJ1VW5LWHp6SlhaNWV4SktYSmVlRGRRY2JG?=
 =?iso-2022-jp?B?TURReDZIa2l2TFhjTDE1Sk1qd1hHNzFMcndOS3duTHRUdkRiTk42Y3Va?=
 =?iso-2022-jp?B?SXc0c1J4UWpWc2pLYmUwWUk5L0o4UGcvZUFEMnJZSm1XdFBkSzJ4Qlg3?=
 =?iso-2022-jp?B?ZGd0MnJhY3d3djErd28vczBReGRWV0YxbzlwSG5VQlZuMU1DM1lHZDFE?=
 =?iso-2022-jp?B?N1FoT1hTME94V0hrVlYrdjJrbE44Rjd3PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?K053ZHlUVUN5cTl2R0Nud1VJT0NvdFRtbStSMUszWlQzMmZFdDZ2bFow?=
 =?iso-2022-jp?B?OERrbE0xVExXck53YlNnYUFpL1JmWUVqZ1JUbENOYy9LTEFPMWRRYmNV?=
 =?iso-2022-jp?B?REsyZnhRbis1T010emgwZFhBVFE2WnVNbExIZCtodGhrdjBsbG1pNEpB?=
 =?iso-2022-jp?B?Y1d3RE9kTWhVVVpQc1B3N3FuZDQ0NHpXQkVLUkF4OElVWWI2RGo0eVk2?=
 =?iso-2022-jp?B?bTladTVuNjRQdFF5S1RBN2xHNlZmbldqd2NqQVYwMC9pdDV3RWlXV3hw?=
 =?iso-2022-jp?B?TEI5d1Q3ZE11WDVHc2V4UytzNnhqRHB6akxBa3A0ZzlkQjNPTisyMW5l?=
 =?iso-2022-jp?B?bFRvUmtUaldtbFhpTGpXd1Q5bVFjVmdWREZMZFB2QnJ5dnRPcjhscU9E?=
 =?iso-2022-jp?B?RVc1YkFQcGUwQzFCUmNTU3p0UkhMZUppdmJuekh6TUpJNDgvVDI2MFhp?=
 =?iso-2022-jp?B?Ym4yS1lod1hJOU13bk1BTHBpdzZCRDVPTm1UTnB6VHRFMlJoUk5ORlNj?=
 =?iso-2022-jp?B?SkRGT3YxdVRYWjIzZXlMNGZ5a1RGc0VZODloWlQxUTdZUEJsV3Bjc0lR?=
 =?iso-2022-jp?B?Um44TWVhV0F1WW9RclhEWS9GMEd6VGpFckplUk1rZG81ZFZmcmJXeEov?=
 =?iso-2022-jp?B?em1wM1JNZ3Z5dldSR1dGRjNVYjlkbGdQN2sxNXU2dDBKZWJrbUNzbHla?=
 =?iso-2022-jp?B?eTlmNjVmeENDQ3haRHVnbW1TODV5RlZ1ZE9XTFMyV21TdXBRTUdMejY4?=
 =?iso-2022-jp?B?K0FLTjNvdEFWMWF5UFpyTllWakpZNUtWOVhkV1dSeVV2Q2xhRVdmRE9H?=
 =?iso-2022-jp?B?RWZWNFRwdGlHQi8rdFlPV0ZoUTFjaGNmd2ZHT2sxaEd0bXd2QjB0d0h5?=
 =?iso-2022-jp?B?RElwV2FIaGt3Qk1oR1g5Y0p2SjhkQVJML2FjN1VoaW9uNE1Eb2NjMGxP?=
 =?iso-2022-jp?B?Yks3WWVXQUNwcnEveC9SS1VWOHgwVVlHZEQ3TXdGb0loVFdyTlJRNG9H?=
 =?iso-2022-jp?B?bGpiTVhyU2M0UnpPa0pYVmxSam9zd3p1d3k2RnVMVk5pU2p4WHE1WEpS?=
 =?iso-2022-jp?B?M05TSHA5OXFjd0RodkJkWVhNUWgyWnNhcUtDL2hKWENyZWVQbWpva2No?=
 =?iso-2022-jp?B?Y0M1QWw0aERwNHE4QzNyb0VNL2JWTmlML1BaUjN5a0kxSHJoZW9yVXlo?=
 =?iso-2022-jp?B?R3JTUTJMTTJDTUR4dzhyYk8vQWtyeUtNdFBGaWNwbUpxSStRcGhpRkY3?=
 =?iso-2022-jp?B?TEl6ODBkeTdKNE5FUFJWZUZuMnN5cjdwdmZwUVBxMTVueVEya0N2NWlN?=
 =?iso-2022-jp?B?amNXbjY4VGJlcnZnTlZLSVFjM0VVMnU0amdyZC90NVpqOU1FL0ZhOFlt?=
 =?iso-2022-jp?B?N0J3S0VJZWpMVEw4b25rcGxzNlVSY0VVc1NYQ0hjem5zTUdybnpXR3lq?=
 =?iso-2022-jp?B?Qm9mQjdBU3pKRGh4aldpdmUyRm50THFEbXFPM1JyNFlxRzkwUFh6Q0NV?=
 =?iso-2022-jp?B?R2hGMy8rbkgvZUZ5Q2tpT0tiUW5QNFJLTlNCMG5sbjlxeTJjSWM0b1g1?=
 =?iso-2022-jp?B?Nmtwb3p6NkF3RkthMS9lOG5vNWgyaWF3VkR6emR5V3A4T3BldFEvcW1p?=
 =?iso-2022-jp?B?WkE1dHhSdG5FL1lRTjI1U2o5c3RPcEt0VWNzOHcvb2ZqZ3IrZU9ZZEEy?=
 =?iso-2022-jp?B?bTR5eGhDbStmWjB2VmJVTFB0Z1h6VzRzMitlYXYvVmNBWHVvdWUyWUgv?=
 =?iso-2022-jp?B?UGRzSHl2Tm9aVEhCa3NQUERxOFAyUG5ySU5VQWpPMXhVT2FKd3R1Smcz?=
 =?iso-2022-jp?B?aVBlZ2lxTFR1SzZmbnBQQWF6T1FHMk92a1U1M252TExZaGZDc1MyVVFs?=
 =?iso-2022-jp?B?cFVOOU5ub2p6NmhySStIcHRFOFV0RHZkS3B3aFBDejduUjI3d0pSdkxX?=
 =?iso-2022-jp?B?QWI2QlN2N1BWZnlDQzJESlhMRDl2RmJJUTBCVFJhQnpsMHdhL3hVdzBP?=
 =?iso-2022-jp?B?RXJQSmhycVdoWlVMRytEZVhUOGhCN3dXaTlUaW1yY3N0amFyK3ljREs3?=
 =?iso-2022-jp?B?cTFMOFpBd1pQOWk2ME9YMEhMMHdtcWQwbEdoQkVmR3o3RU54UEZZMEo0?=
 =?iso-2022-jp?B?eTZraXlxTkgyY1JTSnc2WDJRbC9sZTFVMklCUmUwTDFQV3ZtOFRqSFdY?=
 =?iso-2022-jp?B?U05QUHNhdkNySytnSngvTFF3Vkh6WjNvUlczdXR2UHdiQUFLL1J2OENr?=
 =?iso-2022-jp?B?TUl4UVpMaC85VHBzNFAxOC9seWtvc1FqMFlwYWhoQ0pCSktCdzlObzh6?=
 =?iso-2022-jp?B?dklQSE1EOFo4RWMxU2VoaXE2RzcvSFdvVFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9785afeb-54af-4f48-8414-08ddb2d50bc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 04:10:25.1707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eoAoYyCuCxYuNFddNWsFiHz9D0oK8RBNHok35G5egzCbw58XKDro0+fG9OmPbSGIVkCJKXs4pRnWBHBp5p+1oacUjKkRjHN2PN8Qe8vVyVnwTWs4tnJ1RBZJ5psLV/9s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB16361
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 Jun 2025 04:10:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19220

Hi all,

> -----Original Message-----
> From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Sent: Monday, June 23, 2025 7:29 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; tomm.merciai@gmail.com
> Subject: [PATCH 6.12.y-cip 0/7] Add support for RZ/G3E WDT
>=20
> Hi All,
>=20
> This patch series aims to add Watchdog Timer (WDT) support for the Renesa=
s
> RZ/G3E SoCs.
>=20
> The RZ/G3E WDT IP is similar to RZ/V2H WDT. WDT0 can be used for CM33
> cold reset, system reset and asserting WDTUDFCM pin where as WDT1 can be
> used for CA55 cold reset, system reset and asserting WDTUDFCA pin. Other =
2
> watchdogs can be used for system reset. So define WDT{1..3} in SoC dtsi.
>=20
> Thanks & Regards,
> Tommaso
>=20
> Biju Das (5):
>   clk: renesas: r9a09g047: Add WDT clocks and resets
>   dt-bindings: watchdog: renesas,wdt: Document RZ/G3E support
>   watchdog: Enable RZV2HWDT driver depend on ARCH_RENESAS
>   arm64: dts: renesas: r9a09g047: Add WDT1-WDT3 nodes
>   arm64: dts: renesas: rzg3e-smarc-som: Enable watchdog
>=20
> Lad Prabhakar (2):
>   watchdog: rzv2h_wdt: Use local `dev` pointer in probe
>   arm64: defconfig: Enable Renesas RZ/V2H(P) Watchdog driver
>=20
>  .../bindings/watchdog/renesas,wdt.yaml        |  4 +++
>  arch/arm64/boot/dts/renesas/r9a09g047.dtsi    | 30
> +++++++++++++++++++
>  .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |  4 +++
>  arch/arm64/configs/defconfig                  |  1 +
>  drivers/clk/renesas/r9a09g047-cpg.c           | 15 ++++++++++
>  drivers/watchdog/Kconfig                      |  7 +++--
>  drivers/watchdog/rzv2h_wdt.c                  | 16 +++++-----
>  7 files changed, 66 insertions(+), 11 deletions(-)

I reviewed this series, looks good to me.
I can apply, if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


