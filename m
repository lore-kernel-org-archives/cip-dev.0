Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73C0EE7FE6
	for <webhook@archiver.kernel.org>; Fri,  8 Sep 2023 12:31:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.37587.1694176263067068745
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Sep 2023 05:31:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 388CUdeV2177038; Fri, 8 Sep 2023 21:30:39 +0900
X-Iguazu-Qid: 2rWgoVec2SrWqhceK9
X-Iguazu-QSIG: v=2; s=0; t=1694176239; q=2rWgoVec2SrWqhceK9; m=dJyLFaqBZDhbiiHFYvYOO+GV0jfoxokER53vYjjXbN0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 388CUahA220349
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 8 Sep 2023 21:30:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baasKMqkIwDm30/y3zXahict9frdNgEaleX/XjteIKk7By598BnMwEQCbBC0j2GrLc0xCE6GXdOM1Zduq8+4TDys9biCB1Gkgqs0oS1pJI3nkrYOCDrznGBasGCYJXT+eIE6H9djaN5zKOgd456Hd69693sVGKJBvBOSMoNbBWZyAT4gA6DQxYoTkJijAOLRyKpWajjyKUz77QQONhqAhDpN3fAHTjfs59CwYXprp6AMaLBvmhfPr2g7rCHwZkh7rxr6oZ8QubAbft42veCLvkY8BW59DOGezc9f8h4djYnxcCuB/vNSFvqgjTfUQkDEBpgXdr3WaC7THE4mJhfuhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHzdII6/M2kVucdshvllxBDrJCa13s67LP/E3nZjFwc=;
 b=NS03eHyaZ2/o+gcP1XTAovHQarDJGvz1cvZ1rzEWwr1eeUGyttpMF0KtNTd5XnIq0/qWx2Zj9OTf5aCAuyGuIw1id6QmMYLBpn0Dh20QxqMBbRsNlRR3/oOkfFsz7Xmd1tWBbOepYpDJ1X45C/n8pauksot9WYCFUAbA4XENJ7z5yu5CsH2cGLQ9VQOD9LGO69LfuYuTDrfmbfiShshvHUNcb4gBOh3j1GJuLjxcHCwddqdZblKHZoWEeGpGisTyOH+r2w8jcUG1gDdP9TYwQg1yxVPw8+6U+Hv0Ij4/7p3TqFFRsSlgEK1ZhzPNQXDbObNC5Mxu2go7xQ27A94H2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>, <uli@fpond.eu>,
        <Chris.Paterson2@renesas.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v6.1.52-cip5
Thread-Topic: [ANNOUNCE] Release v6.1.52-cip5
Thread-Index: AdniTq9LEbihszg0RN+K+tBP1JoyYw==
Date: Fri, 8 Sep 2023 12:30:34 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB942033DCE4A112BC6C8B750692EDA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OSZPR01MB9360:EE_
x-ms-office365-filtering-correlation-id: cb1ea0b3-fa11-4054-5ac1-08dbb0676607
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 3myv04fwFhpCcOfNmie3UGSfxjsQ+2T5+MDDK6Svw7IOjasJTITwsX8Gh/RZuPWmOKrze+IIWuV31z5ALnVMjGufSKAOvE4XvGsQdeNxF5DErwwGyg8EQ4PcI7M+RRpuDcEtqHBZYfNTXXozvCnBYBJqcOy6I2rzlmBDZgB6HHD2OypS6NLsDser/anFhEH2oxFhWLQiCvEhxOSUkqaat0EbSe99GlUURRV5VZOObioH3P2dv4GRgmfUhgwXdANK0tf9G1UjRtkFumFk5l+VJ8faAJD3QfWNV7W+ah1q54LBLIw//kLqK/s/sNrLcAdKNa8obEkcNVowQ9BfJmS+aBkh0oDOl8RED3YABRrlXlJ9xgzurUGWbFGIrejNff/dAEk6FGDGysnwcXarYX1p0OAD4sc9GSQly/O7jpluOYwdlCTHSrevKlM1Ryoz1N57S3ATb37zPCmkpOtjquL94Ifpt0HRQBs+tq9xVvK4Iqx/hwSrtXZ96nSaZhaDb5UJqlhK8XTPtVusK1ySPk0F0eqEJ2cDLtvW9f5G3IAJFhrHQ0IrNpKJfiq5QyjhWkmk4pWQ5NOauIpHOfUUUrwRtGlIt5vss8DQcboDOZ67ALRYn70ZEtX5pDIlXYOsnsaPgCEOd2gvKluBLBQebBlw9A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(396003)(39860400002)(186009)(1800799009)(451199024)(71200400001)(6506007)(7696005)(9686003)(83380400001)(478600001)(2906002)(966005)(76116006)(64756008)(5660300002)(316002)(66946007)(6916009)(54906003)(66556008)(66476007)(66446008)(41300700001)(52536014)(8676002)(8936002)(4326008)(33656002)(86362001)(55016003)(38100700002)(38070700005)(122000001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NUJ0cmRGOHh0Q1AybUg4RlNvQmxkMXB1a3RLKzBmUnZ6VEE2ZXNWdnov?=
 =?iso-2022-jp?B?eVlOdG5iSHJxc1dndkdxZ1N6aWlodDVYNWJZWkZ3dE1QQ1Z3ajB2U3dm?=
 =?iso-2022-jp?B?dUtHYjh5SDNWa1RqbDlxNGZkazhZOFExM1ArMDV6ZWlTY09DbkxCZ2Rz?=
 =?iso-2022-jp?B?U3NNQklSdFVkZitwV2ViV2R4Nzhlbjc1SFpxS0tvRUdEdEZncjVla0xr?=
 =?iso-2022-jp?B?NVNpdS9aanVBUVlBVXZ4ODR0WEh4WWxxUzdDTXFOb1o0a1BPckV0UzI2?=
 =?iso-2022-jp?B?QzU4SXNidUlldC9TeXd5NE5HcGtWZklBWU1vMklWcFJqc0VYRGZwTDNi?=
 =?iso-2022-jp?B?MHVSeWxxdEZaQzIzUGV1ckVkcWhpQVdPTE9VL2VMait3UTJyUTJwd1FO?=
 =?iso-2022-jp?B?Wkg0VXdGL1dOb2tmUGhqeXFOT2ZkRUJMN2VCd0tmb0E4UndDaWd3NTlR?=
 =?iso-2022-jp?B?dWJzQkhiNk9INndCYkRhZWlmZHBSZndqOTM5TU8rMWR5M0IzTjUrMm95?=
 =?iso-2022-jp?B?QStqdkpRSUJIV1kyQmptaEdSYkl3VDNOK1ExYlRCUEE5Z3Z5MzluRkpH?=
 =?iso-2022-jp?B?bkJrK1lHZGlBb2I5K01MaFpnWHM4SjV0cFI4OHVESmlsb1c1Zjh6c1or?=
 =?iso-2022-jp?B?cEoyYTFMOHliOSt4R0NrSTR6MEh6TzJNOTJuNWxlK1FSd2JlZXlhUWtk?=
 =?iso-2022-jp?B?b0ExUkNjMlg3ZUZzcWFFdXBQT29UMjBWcUF2OG5XaW1TUGxlMG5LaHVo?=
 =?iso-2022-jp?B?dFAvSi80U1hsRHE1MlZhMlVScEtUL0VxNG9ZcjQrQ21Hb01nMUdEOUxs?=
 =?iso-2022-jp?B?K21lMGtHazBMbjRDZkk1aSt1WUk2K3hDQUdHTzFNbXVXWU9Ba1paUXla?=
 =?iso-2022-jp?B?VFhJUWZIVVhSUkY1dkhYV1VxRWdRSFR2L0tLcy9DTGRtSUdsTjJIUjgv?=
 =?iso-2022-jp?B?a01DOXJRc09OU0tOQXRWZllxNWJhaTFQUU9tTDNUQ0lLdjBseVBud0Jn?=
 =?iso-2022-jp?B?NDMyVFR2d1Z2SUxiSFRyMm0ydFk3R0pSTm1jK3JTRFpkOUlJKy9SNnRa?=
 =?iso-2022-jp?B?VjFCU1owQXp1cEpzSW1SRnhBdk0vN2hyYnhsbStWclAwaWkwdCt4TFNK?=
 =?iso-2022-jp?B?UHA0bUMzNU5KNWFQLzQ4UmdTMlBhMFQxUkIzWUNTd2FXWWJsd09yUVc1?=
 =?iso-2022-jp?B?MXovUm1wSWtBMGFkd3RhVnJhUzVoTzhLSFVYMmRmUlpVZ1o0cTRRdjJS?=
 =?iso-2022-jp?B?QzNnVXZZQjk2OHpsM240eFg2Z0FGQ1MwdmRUUkVScDZUQ1U1OWR1c0dF?=
 =?iso-2022-jp?B?ZGVnUUR6c3VISHhWYjIwemNjejRZS3NEN3A3Z1JyYlJvNVVncVBtb2ZH?=
 =?iso-2022-jp?B?UUJoQU0yRXNFTVhidW91SWd2b3pXNjRVT1hXYjJseDRBY1RBMXFDOFNH?=
 =?iso-2022-jp?B?Qi9JT215K3I4c3pWZDNhNFdZTlRpRWI3Q3RnZ0IzRmlqVHBZRm5wTWh5?=
 =?iso-2022-jp?B?NDlNUUd4R2RUTVhYQmw5UExRdHc1SHRkeWo5aW4ybnByR2NLMkVjakF5?=
 =?iso-2022-jp?B?ZFN3UmxKczdEMCtSbjRleHErZ0E4dUlGdXppOVFaQnJ1UzBSMk1wTHRW?=
 =?iso-2022-jp?B?NVJWbVE4NUZ1VnhaUFVvNVRVbHB3ZDdrQ29SUGJKRk9MZ0FWOFBZTWp5?=
 =?iso-2022-jp?B?ZXRXRjNZMklJLzJBNFE0eU1wMG9TQW0wL0xsMTYxQ1plR1haQStudm41?=
 =?iso-2022-jp?B?eTBXcDRCd2QycVNYUnNOa0NGYXRDU2xTZDljamVmS1J5M25Mc3U1c0sz?=
 =?iso-2022-jp?B?KzYrVForUE8rVGJUbElid0Y5V3gvbTdFbmxxaDNqaW5vQWNIQ2l5ZWJC?=
 =?iso-2022-jp?B?eXVRb21wUVViWEIzZTVmVVJXeUNmTm5CSWlHeTJETDI4QTgzQkhFa3BC?=
 =?iso-2022-jp?B?NldNSnV1MXVsWHhnTmhDRk4wZ0Z5LzRGNFlLYktVQVF2OEVxODVySENI?=
 =?iso-2022-jp?B?dUpNYlJ5Mjk5KytUc1dmT01ncTVOY21kSWxQZS9FcU5SSHBUYWVLL1I4?=
 =?iso-2022-jp?B?RVlveHUxTEc3VG9TbWhUcjZuSTRKcVc3cEVyOEY0T1dsdkh0d2g1dUY3?=
 =?iso-2022-jp?B?azVjOU40M1NVSitra3VFYVFsY3RjQ1F3dVVWcnNwMFFNeDlHVS9NRWw0?=
 =?iso-2022-jp?B?KzlUVDVGbzNTUk1tZG1rQ3p5OHBCc0JsOHpEMFA4M3NQRE5zUkJyVlZX?=
 =?iso-2022-jp?B?N2dYT25hZnk5UjRYeDZaT0MyRjU5b3BWNURhYWQ3VEkvQjc2S3pCWC9B?=
 =?iso-2022-jp?B?N2ZEckhTeXFaSDYzUkYyYUxXM3V0dHFCbWFpaUtEeDhLdkJrTVZ6V2w4?=
 =?iso-2022-jp?B?VkhvNExoS2tKTTZEb2RvVHQ3d2puTEFPZE5EbHVFbGJuaDdXdGtHa3VW?=
 =?iso-2022-jp?B?Qnl3eC9RPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?iso-2022-jp?B?MHlodWlJUDBTY1NoRlg1L3haU05zT1BiOGFwZVdXTDFEWjlsOUVzYUp5?=
 =?iso-2022-jp?B?TGo3bVp3dC83dzZBamJVdU1BcllHTElmb05CSHBDV3lGK3RXZXJWazBv?=
 =?iso-2022-jp?B?SjJqNG5pYU9iS2ZBaTE5UjMvU2hOZ3dFbUdGN2FyK3E1eE03aGYxNXBh?=
 =?iso-2022-jp?B?Y2UvTXU4U245NGlRdlkxOWpoZHJNMGZwbVExK0djY0VCMVk3V3pVVmdV?=
 =?iso-2022-jp?B?U05MdVNhVSt1RDhSQ2ptemRBWklaUW1WdUtCSmMxY2F1VkpDTXMyc3Vl?=
 =?iso-2022-jp?B?ZTdsREdzVFhKT2M5V3hFZXc5SjBiQmM0c3BZRENaWE9UNEZEZ3UySUQy?=
 =?iso-2022-jp?B?RlpiL1NVS2kwVnBkYlNnWG45ZmxOaXhOQnhHbms3ZW4rMUU4dDFndWRF?=
 =?iso-2022-jp?B?cUVRQkgyZ0t2NFA2VGJXa3RuUll1THMrSXc2TlNsUG9nVWZRZXBhT3Rk?=
 =?iso-2022-jp?B?dVN1dXRKM0V2bWE1YTBadHJqdFBiTkdqZFQ0ek9JTlRqc1prNDNMZXJG?=
 =?iso-2022-jp?B?dlV1M3VvTGF6NHhveXBvSk5zYi9wMWlpaDdlMG9VY1daSjdqZnhYbTQw?=
 =?iso-2022-jp?B?cTFlVVlVb3d1RWNiZTVaL21QR3dBOEtITVhVUXU2cTVWdEVUd09PSnpS?=
 =?iso-2022-jp?B?dGlJMDhkVnV3T01oczZOTnNVUUdMMXcrRkc0a2kzbVZoMGw4UUpQWkFD?=
 =?iso-2022-jp?B?TjZiTGVhaG9lcTYvaDd0RHRQNnd2WFRranJ1cmFFZ2xyc0NXeDBMQTlP?=
 =?iso-2022-jp?B?RGdud3R6MHJhWmVJdlNEakNnZ3FuQkxoTHZ5ZTI5OHRuVmcremRvYlNM?=
 =?iso-2022-jp?B?enZnVERzSlRNUUFqbHJ0c2lkYUhDS0FLak1UczFwcG1SMVFlZTRVdnNQ?=
 =?iso-2022-jp?B?b0x2b3ZkWW1xVXRqQXFETXMrMUtKMDJpblRuU01jTmR3a2tRL09icW9s?=
 =?iso-2022-jp?B?Z1hyZGdMcFQzemVBeGNUaTgvUDluMzhnbDRaVmRFdmdwb3BpdjAwV2pI?=
 =?iso-2022-jp?B?eUVOQzJTUmE4UHROUmE2SGVUOVNpR0lFQUEzNXFzUWp6eEdGVmlGSjh0?=
 =?iso-2022-jp?B?c2c4Wm9Bc3QvdFBvM25uSWFBTTZYYlU5Q2lnMjlNRTlXWDdJZUdiMU8r?=
 =?iso-2022-jp?B?UnY4akZyWXh1bytzTE9RQzgzM29FdGs4VnVMRlYyZDNaSE94a01zTW5L?=
 =?iso-2022-jp?B?UE9jNEc2YjhEK2NOT3BxQWFidEsxRVJjRzhpOFNzSDM1WlRBeEhZMXlI?=
 =?iso-2022-jp?B?bXhKbFA4cnBucENVZzBYRXhzbS9zVFBBeE4vSlhDdEhGMUhVdU5NSWpE?=
 =?iso-2022-jp?B?UzNPOGFxVGZzUTk1Y1BScFVPSStaTVRHVE5aMG9aL3l1cVlWb2dZK0pJ?=
 =?iso-2022-jp?B?OXExNUZzSVVEazBoMGt6QT09?=
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1ea0b3-fa11-4054-5ac1-08dbb0676607
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 12:30:34.2327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NK5FDveWcVO/YLN67s9t/4865bO1HdKQ2fW7kXhZqaSLKBwhrupacwY9dXEIX5xdxv22vg2D8lj2k+eZr4G3Ju8drqW87W/idJT1w/6D56tBknb5oNrMksGJoLZ6bz4U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9360
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Sep 2023 12:31:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13006

Hi all,

CIP kernel team has released Linux kernel v6.1.52-cip5.
This version has been updated base version from v6.1.46 to v6.1.52, and MIP=
I DSI driver
and related DTS patches for Renesas ARM64 SoCs have been applied.

You can get this release via the git tree at:

  v6.1.52-cip5:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      98ee1708ccc7301dbbfaafec75350f88527046a1
    Fixed CVEs:
      CVE-2023-4622: af_unix: Fix null-ptr-deref in unix_stream_sendpage().
      CVE-2023-3773: xfrm: add forgotten nla_policy for XFRMA_MTIMER_THRESH
      CVE-2023-3772: xfrm: add NULL check in xfrm_update_ae_params
      CVE-2023-4569: [nf] netfilter: nf_tables: deactivate catchall element=
s in next generation
      CVE-2023-20588: x86/CPU/AMD: Do not leak quotient data after a divisi=
on by 0
      CVE-2023-2430: io_uring/msg_ring: fix missing lock on overflow for IO=
POLL
      CVE-2023-1989: Bluetooth: btsdio: fix use after free bug in btsdio_re=
move due to unfinished work
    added commits:
      CIP: Bump version suffix to -cip5 after merge from stable
      arm64: defconfig: Enable Renesas RZ/G2L MIPI DSI driver
      arm64: dts: renesas: rzg2lc-smarc: Link DSI with ADV7535
      arm64: dts: renesas: rzg2l-smarc: Link DSI with ADV7535
      arm64: dts: renesas: r9a07g054: Add DSI node
      arm64: dts: renesas: r9a07g054: Add vspd node
      arm64: dts: renesas: r9a07g054: Add fcpvd node
      arm64: dts: renesas: r9a07g044: Add DSI node
      arm64: dts: renesas: r9a07g044: Add vspd node
      arm64: dts: renesas: r9a07g044: Add fcpvd node
      drm: rcar-du: rzg2l_mipi_dsi: Enhance device lanes check
      drm: rcar-du: Fix Kconfig dependency between DRM and RZG2L_MIPI_DSI
      drm: rcar-du: Add RZ/G2L DSI driver
      dt-bindings: display: bridge: renesas,rzg2l-mipi-dsi: Document RZ/V2L=
 support
      dt-bindings: display: bridge: Document RZ/G2L MIPI DSI TX bindings

Best regards,
   Nobuhiro


