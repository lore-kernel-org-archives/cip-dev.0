Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF4EC2BA18
	for <webhook@archiver.kernel.org>; Thu, 20 Jun 2024 23:19:44 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.61081.1718925579059929410
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jun 2024 16:19:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=OMgmogRU;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=1718925555;x=1720135155;bh=hr
	OU6S4WxVvX8WemYQUMnQEPg4J3nSsID0sWmHsdYHw=;b=OMgmogRURjg+RPqlCdnWSxqg/WnhGK6y
	qgP8sX8GLOqHlTsusQMLOF7emoS7V2dkSJglp+3hLa6KaGkkcSPpVCIvMlnenWdh0UaAGoP5x2T+j
	6t2wGDjP7IHacIj4aMUd62tNzyqPza5F2mWIDm6UbOu5lzk9QfXE+CWtkLkabHzXUjqIog4IgvzPN
	2AnPSTyQTH9jIYJRzE8NhtRuXTaZUOLJ7Ou8yBbUh8K0R5ETbzkZE3Tboj1LQftBRyR35NmrdwtBO
	XncHLR6HVMVV0kTBfkKrEcz4XXl5EOyZQkGDFn/+6moaoSL9iMalMRQla2bvPnAzxF+o+Kghkl5N9
	Fg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 45KNJEW4992154; Fri, 21 Jun 2024 08:19:15 +0900
X-Iguazu-Qid: 2yAbfjWam8bpgj779X
X-Iguazu-QSIG: v=2; s=0; t=1718925554; q=2yAbfjWam8bpgj779X; m=snIpOlMy/SH8kDq7GrAZBE1fKAsF9kaI560vXa3mbgo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 45KNJCBf1749080
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 08:19:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZ6XBpWSYFQBSrzZkZjUEoESP67xJwTm+VrDGcjvXvnY7EmOUWanQsqXYiHoQcN8LZkssOcOmocKv005oWCa1EKNSppRH5WlEG3KhdfAPtOOImjg/m4TQZBCaaqe3CafAS4Qb3/e9rCq9QLUuLFzvx9Ugj0B3muAf7RHF8Ga0KMmh3/IyaIBGLgxpfW76HC4PCA/Yf5Xezkg5JrjR3e9lmhFTNVndwbzxY/VG2lko0CXX66K0r2v4eXhMsnKTEdGymWeRQRsNh2ztoR6znaidtnEzUIMhKeg/8APcLBOVcAlVTSmyy0hoCW+1tuW5XvtSHqjC5Duqrk4gZZ97OdN+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9gagugjbk8I3DWBBCEyHWNmnmghmNJUXYqLeELsDTo=;
 b=mdlmFjtLfmvQI7F2+vBnZWbUMimai6jX4Fx/5H79W7O5fHL82Xl+fmY/QJ8IaQLgu8d/NH7qiscSlqVdcxn1m6X+f9hwPOSImRkexvm4y7N+O5/In4orAwMyNtNqhM5n/PMuhU908ddc/ADXF2pyY5D/dzCr7U7Jyle2htNMJEO4Yg401sH8daG0EqcDLRR1Xh02d8Gh4HnFABgcYj+q38RhSz80dvbeYR8wx40vT2v+HnWsWeDvdovVN2cvi/6sX3Do9BQat5tu83qSo8HYEYCd1RSYL2sSKB+anr51ap/dd7LaN/BI797nRGJ7bubgUW4fV41srAIfQoTxDBSakg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>, <Chris.Paterson2@renesas.com>,
        <masami.ichikawa@cybertrust.co.jp>, <uli@fpond.eu>
Subject: [ANNOUNCE] Release v6.1.94-cip23
Thread-Topic: [ANNOUNCE] Release v6.1.94-cip23
Thread-Index: AdrDZ5Jv44t3zIfSSBmM7WtuO6nfYA==
Date: Thu, 20 Jun 2024 23:19:10 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388F6F3253EE18C3040591B92C82@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OS9PR01MB12359:EE_
x-ms-office365-filtering-correlation-id: 64dc9bdb-c4ae-432a-81c5-08dc917f640c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230037|1800799021|376011|366013|38070700015|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?aXJZTEdMeXppR0xXS1E1SHIrRWRvT3U0V09BQUNqZGJSVjFFTU5GYkNO?=
 =?iso-2022-jp?B?TGNRN0lnQ1FYTnVRUEN5emF2NzVPcFhjUEZQamNhUmhsS3NwWFJUQ1Zr?=
 =?iso-2022-jp?B?a0tzbU8waWQzVldEL0ljWlNxOG9GR0lCTVMvcjlLa1FuZVZjaWttcGZi?=
 =?iso-2022-jp?B?RDRrZ28vb1o3bjFKVjB6aVlOak5Qbm0vb0RNSmdXUDVrVXFKdk1OM0k2?=
 =?iso-2022-jp?B?NDRjaDZub1RtOXU2UjE0QTV5SGs5QzN2VDBQTVJsVVZ3akVzSGJGek5X?=
 =?iso-2022-jp?B?bDYzRFNtbkJGTVQwUkl1TGlxM3F4VFVjYXlnSEhwNGE2ek9KQXNSVjFB?=
 =?iso-2022-jp?B?L3MrZzZEZmYwcVFMZ0dDRGpzK1poT0tsWnE0RHVQNnpVaWlKaDFUWFVz?=
 =?iso-2022-jp?B?dGdxMCtnVWVJeitNL1NFbFlab2tVVE02dEhGcXFzZFcvelY3SVMxK1pZ?=
 =?iso-2022-jp?B?a1lJcFhYc2JaUnNHVGwzUTlBTEZxZ3ZiYTJ4RDVuL2Rud2dMUTFETUlK?=
 =?iso-2022-jp?B?MzVqQmRucWlac3ZZYVEwc2JkRXpvcnRmVGxnQnpMdEg1cExZWmJwZzFs?=
 =?iso-2022-jp?B?TmhKenRFdkZFOTFFcThaVFY3UVFnRTdYNDVENFUzbFVhTi9RcFpWeXkr?=
 =?iso-2022-jp?B?Rjh2cS9NcU5kT2RBMi9nSDk2M1ZZY3gyV3c1U0ppU09TazE1RTRXTzVU?=
 =?iso-2022-jp?B?SEk2MitETzQrZXF3eS9QUExvTHh6QTlRSFpFOTdGWjVDcE5UdXFyUlFl?=
 =?iso-2022-jp?B?UC9zcHN1UWJjUWxLQlQxRGRneXFMbVA4TUYydjBxMEFDanlnSUN6TVZj?=
 =?iso-2022-jp?B?cG1UcmpHSTFOV3dVWWptWlZaaDFISDRYR05vWkI5NjQwOWp2NUU3SElz?=
 =?iso-2022-jp?B?eTJva1FCWkhSTEN3RWFvMXdnWEh5a04vZGgzWW54aktVUnJGR1k1RUUz?=
 =?iso-2022-jp?B?WEh0MUZMTEF4MHRnZW9QR3pLN3Y0UlNyUkRocWNoUjJvZGY1OGZYNEc0?=
 =?iso-2022-jp?B?cm85MjE0QW5TM1lWbVNWeDJ0QjNmWDFWTW81YXhLajJORGJDcEdmTW8v?=
 =?iso-2022-jp?B?UUxwWWsrTVZrS2hwK2NQZEJnQXhBcWZMa1NmRWtraDMvVC9SU3c0cVBB?=
 =?iso-2022-jp?B?RkVsNjY2Tk9JSG8vODBKVytEV3BIaDBOSFlxWkFGTkw0YVRGTHJONEw1?=
 =?iso-2022-jp?B?U2p1ZUhaYzcrdUFZZ25nUHN6bUJHeHVWOHNFMEZmb1RMZUwwc0U1cXd6?=
 =?iso-2022-jp?B?SG1wZEc2dTFjVnU3MlNNZHIvSUZJRFcwYzJTWW8vVTlCY2N3U0JPZzFj?=
 =?iso-2022-jp?B?MTRYQmdPNzN4NnluaTFDZkxaQ3BzOGxweUI1UjNWQWZUVjhsRlJsSXkz?=
 =?iso-2022-jp?B?TzhmZnVwbk5RU2h2a05GWG12T0g0cnVoNjFhOEtlS0ovdGFYZWpYY1JK?=
 =?iso-2022-jp?B?OVY1bWd0bVRmakhuOFhwTXFqd2dhME1RWktMSk5FdVlmYTRsZElGSFR5?=
 =?iso-2022-jp?B?QzZUMW1INTVSaXlXRnJEU3YxajZlenpJcEQ1em1PM3d5RHpqalJjWEhE?=
 =?iso-2022-jp?B?QzltUzhUMmIxdElhcWlLOFV1bWNCTjAyS2RQbjczU2liMEsxZ1crcGhT?=
 =?iso-2022-jp?B?UE5JcXpZRkFoWGdlRExBRFdxczkxV1pGdDRTTkgvVXdMUkY0YzZNOWc3?=
 =?iso-2022-jp?B?WVdhMnpVRnNNR2tET21Oc1BPcDNSVXlvdkZMTFVRY3FZNm4wS1VOUmVu?=
 =?iso-2022-jp?B?Nkp1azZjcGk4eWhyWDI4d2hPZzRhSWoxejdpV3hHL2huS3JtM015NXNX?=
 =?iso-2022-jp?B?VHJ3UkJ3UDBhcnF6N29YZENyZ0g1ZkIyanBYVDRkVFFGWUFHQXJNQU1P?=
 =?iso-2022-jp?B?cm80ZWFhQ0gvWUpTK21zNGdyUEorQVhJUFpiSUJ2enF0OVlWMEhVQ2FD?=
 =?iso-2022-jp?B?OWZkc3Q2VVlCZC9ieWFHaENMRmpUdz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013)(38070700015)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?K29JbklZc0hrSFVpcjJKM0s5bS8xTXFUSlBIODc1YXNvMlZKUmYzbFN6?=
 =?iso-2022-jp?B?c3FxdWJWWHR6WmpxZ1V1R3EwTEhCWHRDSnpQa1poQjVSOGZXdno3UHkz?=
 =?iso-2022-jp?B?VkVGTHdUcy92UWxOMnNrbFYwRU4vZ1RtUWZJeUdYbU1IN0I3c21DNFJN?=
 =?iso-2022-jp?B?eFQxb0EzS0FjYXFVY0w4Z0hKL3BZQU5CZldMNWM4UVZmTjBOMDY1eHhH?=
 =?iso-2022-jp?B?VmI3N1RxWWZnOG9HaVNEUWNvVUxOa1Rldnp3VnhwdVU1cUU0aWtPSkNR?=
 =?iso-2022-jp?B?RmJRZWhncXJEMDV4MUlHQUxIUmZBTElEOVpZQjExZE9FRVJHUlE5ZDBm?=
 =?iso-2022-jp?B?MFFudVptdExGbEFkUWtuZmVKbVNKQ1lRRnhwNDBvSUdYQTdSZytqOE5j?=
 =?iso-2022-jp?B?OUxrcDFkUWRwVHhMMnI2cmNoOHhhb1d3U1ZtaWVncUtwQTVIZFR1RXk2?=
 =?iso-2022-jp?B?K3NDNFJGYm1wWHpIYTlvZ094VytXOW5qM3N4NW12TGs2TVY3Q3RjbFVL?=
 =?iso-2022-jp?B?WTl5dEFmTWVFSFRpUmJGZUtoRGRiNGJIbzFJazRFUGs3TVF6VnVlZ2Jl?=
 =?iso-2022-jp?B?bWROdmxpeVZ4UXEwR0hWclMxcDUydm4yWkpaUlhTU0xrdkdlc0p0blFi?=
 =?iso-2022-jp?B?OVpiV3Y2eER6T3Y3QjBVTzRKTXUyQ2tFSElOcittZjgxU3B4eDhwZkRl?=
 =?iso-2022-jp?B?Q2o1Q0JWeUF2cy9UK0F5dUxnUk1SdnNMVXF5alc5bjJqbUNLallPMzJN?=
 =?iso-2022-jp?B?Zktzbytub2pTV3ptMXo4NFNzQVNGMzhjNXNvaDRnM01vcmVFL1B5YVdD?=
 =?iso-2022-jp?B?MVcwRHlaT2Yrd01kMWJYaWJjMTUyNU1NdVVDTzdTZjJoZzV0MFpCZFJP?=
 =?iso-2022-jp?B?VS9qMzRacFRLRkIvNmZpN3ppQzdWNGJpbWJFc3lzL2pyaHAwekdZSHpv?=
 =?iso-2022-jp?B?N0xETWloa0FxYm5lVno1ZGJZMW80UWR5WlVPN3NhZVZweGRKNDZEcWgz?=
 =?iso-2022-jp?B?SmNiMUYrVlRKWVdwVHhRZlZiaUJtVms1UWVvNEs1d3o4Qk1qa3ZtcE5l?=
 =?iso-2022-jp?B?cHF3MTBKZkhLcmFYRExKSTNZZ2hoQXNDbWFFTE5pTmdhWG9qemRiYUx6?=
 =?iso-2022-jp?B?VStrTnZhM1hSVS94NGlVb2d2R0g1OHFNTjlka2pQNElVQTRINUVwY2lG?=
 =?iso-2022-jp?B?SzJ1dGNrdmRoTFd2MnNOSjVnMTdXRXBYWTZZNzJwM3JZbUFqc1E3ZHFI?=
 =?iso-2022-jp?B?MWdkVDdnUEtrWnNWbUZ5dnFKTy9zMU1INVNqalVPRVZJSkwvR3FyUlN1?=
 =?iso-2022-jp?B?MldLT3o0N0x0eDl0bytFaXVYdXF6U0RQWncwQy82TW9abEpEdHpxbFV6?=
 =?iso-2022-jp?B?RlY5NTlraTZYZEFjaXkrU25aQk11MjhhTjdFUjNaTCtqdGtiU2hHSTZM?=
 =?iso-2022-jp?B?dzh5dnRvNkdQU1Zmc01EWUNaakhOc0FvZGxueUM1RkVuMll0RW1VNXpK?=
 =?iso-2022-jp?B?aDdXNVF5Tjg2VVJ6VWU3K2l1dTc0ZS9nTW5DU1VkV3g1Mlc4YkE0cGl4?=
 =?iso-2022-jp?B?c3l0bmVpdlhRNHdiT216cHdmSUNyZkRGd3NnYVRMRGdBbmYvajBaNklt?=
 =?iso-2022-jp?B?TE16MXJnNUpyUEY2QjN5aVZHVkVSZlZYSnRmZ3lkSHhIekFyWkR0VW9B?=
 =?iso-2022-jp?B?WG1JckIvdmVaVHFJU3lEQ0JJbE9ScTNiOE5YQU5BcU03czhNZ3VjRWZS?=
 =?iso-2022-jp?B?ZjBoVlAvRFdSVWJwUy91bGwrcmlCK1VYQUY1UWdsK3FmaHRzZitHQTZI?=
 =?iso-2022-jp?B?YjZpdGFUMnNyY2ZmaFliR2FQMDFXMHJGK0V2cjBCV2FWSHBTMDBTVzU3?=
 =?iso-2022-jp?B?a3Nab3lMTWJrNloxSDVDVHkyYXVsaDR0TElJMDZPd2tiZEdUemoyQVNq?=
 =?iso-2022-jp?B?dWYzVExxamUvYjVuRk9GRk5zaXVZUUxLdUVZVGhkMVBraVVBOG44WDVL?=
 =?iso-2022-jp?B?TndrYVlTRFY4K3BVL0ZFa00vbUtrOXljMVJwQkc0Ymk5bjAxd3FmbUta?=
 =?iso-2022-jp?B?b2lDcE5WNmt3QjIrVDUzVDJGWjc5dS9rVlcyZU9wam9GVFplUDJrY1dj?=
 =?iso-2022-jp?B?YzI4UFZ2SXoxcTlXSkdxSnNEOG13ek5yMmNHMzgvUVVGeGx5Kys5WFJO?=
 =?iso-2022-jp?B?UFUwYnU0NEx0d0pFZGNmSklRR2FTWXdBTVpzam1Ga0hyZ1E3eHplQnNo?=
 =?iso-2022-jp?B?aGNiUms4RTlDcTZUMUEyTlYxTFlWMUZER2tQaW1GS0daalpjVi9oR2Ja?=
 =?iso-2022-jp?B?WDBCWHBoRURVaHEwYmdjUHlSNGpCYU9xU3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64dc9bdb-c4ae-432a-81c5-08dc917f640c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 23:19:10.4851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2lZkQ5+klyCkEDkCJygxk9hcvslL3Y6KehYKFQa855EsV9eAx+vmwz3hdOb/+MVwGlxt2zVk1LaGYeMw6siydHopZSKQd2gGGM70B/8ifGx++B7D7B+aRAr7H5Gc2T4V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12359
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jun 2024 23:19:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16307

Hi all,

CIP kernel team has released Linux kernel v6.1.94-cip23.
The linux-6.1.y-cip tree has been updated base version from v6.1.92 to v6.1=
.94.
This release also includes patches for the Renesas ARM SoC Interrupt Contro=
ller
and DRM as CIP kernel.

You can get this release via the git tree at:

  v6.1.94-cip23:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      63c8d79d0e6331712687d30af6667e96d7833109
    Fixed CVEs:
      CVE-2024-36971: net: fix __dst_negative_advice() race
      CVE-2024-38583: nilfs2: fix use-after-free of timer for log writer th=
read
      CVE-2024-36891: maple_tree: fix mas_empty_area_rev() null pointer der=
eference
      CVE-2024-35927: drm: Check output polling initialized before disablin=
g
      CVE-2024-38575: wifi: brcmfmac: pcie: handle randbuf allocation failu=
re
      CVE-2024-38605: ALSA: core: Fix NULL module pointer assignment at car=
d init
      CVE-2024-38600: ALSA: Fix deadlocks with kctl removals at disconnecti=
on
      CVE-2024-38610: drivers/virt/acrn: fix PFNMAP PTE checks in acrn_vm_r=
am_map()
      CVE-2024-38612: ipv6: sr: fix invalid unregister error path
      CVE-2024-36016: tty: n_gsm: fix possible out-of-bounds in gsm0_receiv=
e()
      CVE-2024-38599: jffs2: prevent xattr node from overflowing the eraseb=
lock
      CVE-2024-38576: rcu: Fix buffer overflow in print_cpu_stall_info()
      CVE-2024-38568: drivers/perf: hisi: hns3: Fix out-of-bound access whe=
n valid event group
      CVE-2024-38549: drm/mediatek: Add 0 size check to mtk_drm_gem_obj
      CVE-2024-38543: lib/test_hmm.c: handle src_pfns and dst_pfns allocati=
on failure
      CVE-2024-38571: thermal/drivers/tsens: Fix null pointer dereference
      CVE-2024-38579: crypto: bcm - Fix pointer arithmetic
      CVE-2024-36015: ppdev: Add an error check in register_device
      CVE-2024-38585: tools/nolibc/stdlib: fix memory error in realloc()
      CVE-2024-38603: drivers/perf: hisi: hns3: Actually use devm_add_actio=
n_or_reset()
      CVE-2024-38581: drm/amdgpu/mes: fix use-after-free issue
      CVE-2024-38589: netrom: fix possible dead-lock in nr_rt_ioctl()
      CVE-2024-38548: drm: bridge: cdns-mhdp8546: Fix possible null pointer=
 dereference
      CVE-2024-38561: kunit: Fix kthread reference
      CVE-2024-38597: eth: sungem: remove .ndo_poll_controller to avoid dea=
dlocks
      CVE-2024-38578: ecryptfs: Fix buffer size for tag 66 packet
      CVE-2024-38560: scsi: bfa: Ensure the copied buf is NUL terminated
      CVE-2024-38558: net: openvswitch: fix overwriting ct original tuple f=
or ICMPv6
      CVE-2024-38601: ring-buffer: Fix a race between readers and resize ch=
ecks
      CVE-2024-38538: net: bridge: xmit: make sure we have at least eth hea=
der len bytes
      CVE-2024-38580: epoll: be better about file lifetimes
      CVE-2024-38565: wifi: ar5523: enable proper endpoint verification
      CVE-2024-38567: wifi: carl9170: add a proper sanity check for endpoin=
ts
      CVE-2024-38598: md: fix resync softlockup when bitmap size is less th=
an array size
      CVE-2024-38618: ALSA: timer: Set lower bound of start tick time
      CVE-2024-38586: r8169: Fix possible ring buffer corruption on fragmen=
ted Tx packets.
      CVE-2024-38554: ax25: Fix reference count leak issue of net_device
      CVE-2024-38569: drivers/perf: hisi_pcie: Fix out-of-bound access when=
 valid event group
      CVE-2024-38613: m68k: Fix spinlock race in kernel thread creation
      CVE-2024-38544: RDMA/rxe: Fix seg fault in rxe_comp_queue_pkt
      CVE-2024-38596: af_unix: Fix data races in unix_release_sock/unix_str=
eam_sendmsg
      CVE-2024-38590: RDMA/hns: Modify the print level of CQE error
      CVE-2024-24863: Null pointer dereference bug in malidp_mw_connector_r=
eset
      CVE-2024-38559: scsi: qedf: Ensure the copied buf is NUL terminated
      CVE-2024-36979: net: bridge: mst: fix vlan use-after-free
      CVE-2024-36014: drm/arm/malidp: fix a possible null pointer dereferen=
ce
      CVE-2024-38591: RDMA/hns: Fix deadlock on SRQ async events.
      CVE-2024-38577: rcu-tasks: Fix show_rcu_tasks_trace_gp_kthread buffer=
 overflow
      CVE-2024-38615: cpufreq: exit() callback is optional
      CVE-2024-38616: wifi: carl9170: re-fix fortified-memset warning
      CVE-2024-38547: media: atomisp: ssh_css: Fix a null-pointer dereferen=
ce in load_video_binaries
      CVE-2024-38545: RDMA/hns: Fix UAF for cq async event
      CVE-2024-38556: net/mlx5: Add a timeout to acquire the command queue =
semaphore
      CVE-2024-38582: nilfs2: fix potential hang in nilfs_detach_log_writer=
()
      CVE-2024-38602: ax25: Fix reference count leak issues of ax25_dev
      CVE-2024-38607: macintosh/via-macii: Fix "BUG: sleeping function call=
ed from invalid context"
      CVE-2024-38546: drm: vc4: Fix possible null pointer dereference
      CVE-2024-38552: drm/amd/display: Fix potential index out of bounds in=
 color transformation function
      CVE-2024-38573: cppc_cpufreq: Fix possible null pointer dereference
      CVE-2024-38588: ftrace: Fix possible use-after-free issue in ftrace_l=
ocation()
      CVE-2024-38587: speakup: Fix sizeof() vs ARRAY_SIZE() bug
      CVE-2024-38550: ASoC: kirkwood: Fix potential NULL dereference
      CVE-2024-38555: net/mlx5: Discard command completions in internal err=
or
      CVE-2024-36972: af_unix: Update unix_sk(sk)->oob_skb under sk_receive=
_queue lock.
 added commits:
      CIP: Bump version suffix to -cip23 after merge from stable
      arm64: defconfig: Enable Renesas RZ/G2L display unit DRM driver
      arm64: dts: renesas: rzg2l-smarc: Enable DU and link with DSI
      arm64: dts: renesas: r9a07g054: Add DU node
      arm64: dts: renesas: r9a07g044: Add DU node
      drm: renesas: Add RZ/G2L DU Support
      dt-bindings: display: renesas,rzg2l-du: Document RZ/V2L DU bindings
      dt-bindings: display: Document Renesas RZ/G2L DU bindings
      drm: Place Renesas drivers in a separate dir
      arm64: dts: renesas: r9a07g0{43,44,54}: Update RZ/G2L family compatib=
le
      usb: renesas_usbhs: Remove trailing comma in the terminator entry for=
 OF table
      usb: renesas_usbhs: Update usbhs pipe configuration for RZ/G2L family
      usb: renesas_usbhs: Improve usbhsc_default_pipe[] for isochronous tra=
nsfers
      usb: renesas_usbhs: Simplify obtaining device data
      dt-bindings: usb: renesas,usbhs: Document RZ/G2L family compatible
      dt-bindings: usb: renesas,usbhs: Document RZ/Five SoC
      arm64: dts: renesas: r9a08g045: Add missing interrupts to IRQC node
      arm64: dts: renesas: rzg3s-smarc: Add gpio keys
      arm64: dts: renesas: r9a08g045: Add PSCI support
      arm64: dts: renesas: r9a08g045: Add IA55 interrupt controller node
      dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/G3=
S
      dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/G2=
UL SoC
      irqchip/renesas-rzg2l: Add support for suspend to RAM
      pinctrl: renesas: rzg2l: Select GPIOLIB_IRQCHIP and IRQ_DOMAIN_HIERAR=
CHY
      pinctrl: renesas: rzg2l: Add suspend/resume support
      pinctrl: renesas: rzg2l: Avoid configuring ISEL in gpio_irq_{en,dis}a=
ble*(
      pinctrl: renesas: rzg2l: Simplify rzg2l_gpio_irq_{en,dis}able()
      pinctrl: renesas: rzg2l: Configure interrupt input mode
      pinctrl: renesas: pinctrl-rzg2l: Add the missing port pins P19 to P28
      pinctrl: renesas: rzg2l: Include pinmap in RZG2L_GPIO_PORT_PACK() mac=
ro
      pinctrl: renesas: rzg2l: Improve code for readability
      bitfield: add FIELD_PREP_CONST()
      clk: renesas: r9a08g045: Add IA55 pclk and its reset

Best regards,
   Nobuhiro



