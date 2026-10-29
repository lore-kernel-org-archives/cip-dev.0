Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6120.1793256344508965238
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Oct 2026 23:45:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=T2tdtmFv;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.152, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1793256342;x=1794465942;bh=
	4ey+ehCNY4w2AO9M3MdnnKEXJj3qSISl4KmaEyaQXyw=;b=T2tdtmFvaA96LyXTUcDWSii+J8Ek6/
	Gij3XTJueF6bo4XUhF9T5NpqYTyi2HhDb49271iZ2nWLLWrjqcvnhhuCNFs/6tpnWMufrN/nJ6xfJ
	CFh803uIDcZyp8INk4c7y5aCeY0NVdjW7rYB+x68C7wvv4YX4SPdFZCSiwHFwbpvzhtLTdV/V0phM
	o5Y7rO44mbi6qDE+B1coffnLYfF8hldovOr9vVtCb1y5NxYjCQN1Hqc8FoXGzcfy2SgLfgRcAtXwi
	kgqej3+Bkmhb2K4y4iXDMGFQbpmEj7a99kOCqCzR+7lAqP2FyUs3lFtSofT4UlFqxStmJhRx3xGKj
	d1KA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 69T6jfma2071399; Thu, 29 Oct 2026 15:45:42 +0900
X-Iguazu-Qid: 2yAaPpRdHItcnWzP6o
X-Iguazu-QSIG: v=2; s=1; t=1793256341; q=2yAaPpRdHItcnWzP6o; m=iSh3GxQ1YRBJ7oqjudGk63IUSZUUCyNH0Q95lOhE9Zc=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jFZVs1MXnz1xnZ; Thu, 29 Oct 2026 15:45:41 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vEPbnaWPYwm7T4nxuFF5X0Z20Nr/yCEXe8ywWEMAGj2T649cgK/kpNstOXjBTWmVu9zPHQfM8RmQYu8G8ZCqa+QNZciyeYWo5UZnmC2liqXMDIeFrfYZkpIaLPqVU6k4AhYI+NLtPVmI9JHz6HQBfKSNgW10ckODEjnHvb6oAP6gwFkmzc4VZpwf7JCm9XTCqERAg2q/XSOUTzm6i66EP6qBTh7jA5tpgt79z1M1l+wPvqMLyAitW8K6+bgqgk1+QBNta646EWWhcmH10/orDxU14+CO0s/WBMk1xmBjQRWcUbcoM5jE+zd0Cmo2PcnQjUKB9FTnBDrAOkE7InXSFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNIZWmMaxX7NagrgpDIfMuBgSqsiQu12pbrJCLFO6UM=;
 b=Wyn6JJ0R5c0N5xsACyOq/XzYtibIfpPfhR0b1sm0qEY35JTaAH8FeEEzKfHwP8EajpkiB/nzDSODEPksqvKT9zaq1hWgNVisZ0BDLOONKuCEi2fjYqeAFyi+Q2UD2yw7R4V9Z6iYnvXIVT4Q6MhNMsJzIWWlO8dUTKCRdGzIc8VBOpHTfdbi6PPQuTNb0+3IOuH/R/4EJYxo4OfPxImBGJCu9/Tg+P1xeFhlj+OkAYz6I7gXzk8wTlF3KGq2fkSXB+UMNrCGmh6iai19hKT3NF00Ffa9ZnC6dRWnPZTI2whS5/mstvJTu1pTkEfqm5nc6ghvz+6xsHwi5ywwSZT3yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
Subject: CIP IRC weekly meeting today on libera.chat
Thread-Topic: CIP IRC weekly meeting today on libera.chat
Thread-Index: Ad1ncM8pCEqDpMdcQAa44NF4V6KOVw==
Date: Thu, 29 Oct 2026 06:45:38 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB14818B13FA2A81593C33A4DFCCD6E2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY3PR01MB10220:EE_
x-ms-office365-filtering-correlation-id: 983a12d9-f58b-4d94-1838-08df35883e6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|261028144727099003|38070700021|11063799006|56012099006|261009223027099003|261026140227099003|261021135927099003|261022105027099003|10067099003|261022075727099003|18002099003;
x-microsoft-antispam-message-info: S2qozlRIKOQy2HDjxEDA1piqcY4yz7+NydMw6GaK4Ea5zkRnpPAsNyMAy3ls/4LUcqyhW9ujA+KPUezSyYcZDIOfiVqwfwEtsilp/dksTz+bvI0+OUINfnSdIvzOZHXmpegCiGMvgo6NK684EwT4D4yCLkREkrFMiKHPVJwIfou0+z+blFDW/8IH0yNpbONy2Nda50c653WgI5ripvNfvynGSIfJ3d5rmnFI4yQO6jglS5qL0GutfmUQXkZcLPaCFQEM/RJPmlQGGSzKWQqV2q74jG0E5/yUPJRivU2zlXpwB2Fm0yXT5rRZ9Mxpz8rCEIaJSEhYeQUU1jpZujvYEwoLN9FbhBbLE+GR09x77xU6qi+ZNhYd/BW6uZkPySotv32H97fD61npVS+n/KMCIxusGEZMSbSylwAyp2c95UnRAk6gr/cZezA9H5EPjvoePTnhJ049RpkJKqYeIc+K6ORtGjbt1OloNVj2Dgc0yXZHrgm0yxmAy0iQmujoSRjL2Ddp/WvkYY6i5R/HCGJQ/V+qTO2iOoQLWMgFRqLS2CpKNi3+c5+79Xv3n9m81t2/xXSsoCeKI8+vxSQsb5OWy1DrL0awZNdL9Kn4zAI2o14dNHd9hIE3RZPD9bTRvq/YhwTnYXexB+TNM6FMaVP/OuDeh768D1AYWKK3n17J+Jw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(261028144727099003)(38070700021)(11063799006)(56012099006)(261009223027099003)(261026140227099003)(261021135927099003)(261022105027099003)(10067099003)(261022075727099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?b1BtUG42Q2FEbHJsdGxGV05VK2F2aVUvcGF4bVZKcVJIWG03cVV5ZkVt?=
 =?iso-2022-jp?B?QWxzNVNBL0JHTjgxeXczS0xaWDVBdFI0VEdQOEFxMUJrR3NyZlpQaXRx?=
 =?iso-2022-jp?B?dmVsUHNJT1k0TXR4TXkrOEwyRVcwb3pSUHMySE9VOEMrazVwQWl3T3F1?=
 =?iso-2022-jp?B?cGZWQkhLTU4xbGtFaHdyWHBvb0MzVmI0L0V3eFI5eHJRam12b3d3RkJX?=
 =?iso-2022-jp?B?UzlYWC9seWt2Y3JQUTR3WUxEdlc3UnV3Q2NiVmxwc0Qva2JWbGdrQXM5?=
 =?iso-2022-jp?B?THMyZ0o3STJyR2JrakcxeEo1NDFWU1FjRjZra3JYZStITThOaDlmY2pi?=
 =?iso-2022-jp?B?N24zenlqdTJxcGVTZ1J2OHN2NzB6MEdkY3h4S2U3ejNLcnVyN0Z5M1do?=
 =?iso-2022-jp?B?d2VTdkxXZUFPLzBxSVIyelU2QXhKYzc1aXV3aGxGQmtKNkRzaHZQTUxj?=
 =?iso-2022-jp?B?NHJ4dy9adUwwd0RaM1pUY0RDN2J1VU91MGJGbVhQRm5vVHNBdzRoREkv?=
 =?iso-2022-jp?B?a1RwT0VwNGpTUmFWeEpuNGhiVFRSekFyZjBkTExRU0pFZVVxam15Ynp4?=
 =?iso-2022-jp?B?TVNVM0RNcjdMZHlGamR6UGoveWhvTUg2MGJCVGFHampidVF0TVBKb2hj?=
 =?iso-2022-jp?B?UEJZcEdxU2JSaG1GV1RxMSt3bzJYaGRhK0tQTU4vSFNWM0g5RElPS3Nz?=
 =?iso-2022-jp?B?SS92ZmNwajc5ZHh1dXloUmt6U2FmL1p4T21FemtQcVJXSjY0QzN5cjQy?=
 =?iso-2022-jp?B?Q0ZZMlh0a0RpOGpiOGlUMDRxNUc5VjM2QkIyMmx1bUkzamtBY3REK0hM?=
 =?iso-2022-jp?B?NzQxNHVBbXdrVFAyNkl2Z2NlVXNpVVdGclQ5V1lBMWt2enFkU0g1azRj?=
 =?iso-2022-jp?B?UklWYXBBdy9oY045Z0lkaVJWUU9yRWlCOEtXOGhmaEhPTGU4dzVnMFJR?=
 =?iso-2022-jp?B?aDUzTWpGalI4KzJqMGJhc0VRWk5iZXpPTktoODIvVWFIZlNzQ1NpYkRT?=
 =?iso-2022-jp?B?SEk2T2tHWkFsNjhINVNUOVZoQUFKUVhuOG9wdDkxTGlXWTdzYWVkNmxN?=
 =?iso-2022-jp?B?TlRURWJ6Y3BNR2VPeCsycndIVXE3aE9JUHRwT244c2tFYjk4dTlvaUxJ?=
 =?iso-2022-jp?B?enhURU9TTisyZGQ3TFh6K2cwM3RrNmw2eDlFNDNlTTVtQVZaOUdtWVNH?=
 =?iso-2022-jp?B?TFdtVXFsZ0Z6ZmVJM1JVNkRxKy9ySGVCYWVxTlVLN3JxRXcvZ0JxOXYy?=
 =?iso-2022-jp?B?YjI4UWlOTmFqOTR3aDBqd3pCeU5Xem8rTS95YmN5OWdVQUR2c1pod3Q5?=
 =?iso-2022-jp?B?dVRLOTNIZ0VYSWJQRzQ0OVdOV1NnVXR6RlExUFpNM2RHKzVRa3BNYyto?=
 =?iso-2022-jp?B?d0JqLzNDRUV4VFJFLzNLeUt1Y1RVK3RtN0ViZDJUL04wVXlQdzE0c2xw?=
 =?iso-2022-jp?B?VUxPamZ2NjFUKy9mWVcvL0g2bU5JLy9WMXpNRjFDblBzY29aL0YvaTJn?=
 =?iso-2022-jp?B?NUVHd080V3VrS3E1VkZNM1orREo2SDZTZU1qM01BUmhueE9RaHJldVpl?=
 =?iso-2022-jp?B?clM4c3c2QzBjcG1QVnlGWnByVTZjN0dXQ2pmTlZUWFYwdk84N3N2cVh6?=
 =?iso-2022-jp?B?aVpzcWJEY0dmeDRKb0E4eWMyRTROUVJFMDFWZStLTzJmVnVsVnhrcHow?=
 =?iso-2022-jp?B?eE5PUm1rMHNKZTdFV1dQYkxoZko2RFdZZUJXWWk5UU1PK0ZsKytxNHFP?=
 =?iso-2022-jp?B?UTRJUkZSWmhTSk1VMUlHQUhmZnZxNDEzOGFOeVk3VGlQeG81MUpnUHM5?=
 =?iso-2022-jp?B?MGw3VlBNdWJpbUVFZ0E5NEorU3NMaFU1UGhPU0o0YlFSdEVhMjA2bjdo?=
 =?iso-2022-jp?B?ek1CMFBlMGZMWDhyaENKQjVDOVZHOXVQNGU2VGdNT1RWY0x5N095RkhM?=
 =?iso-2022-jp?B?RXhIK3QwRDF4NlRQU0w4ejk0QlhUcTljbTBIYmhrTVVQeEt1YkJ2Q0hp?=
 =?iso-2022-jp?B?bFp6V3RoNHdYVTl0MXN0NmRJODVBQnYrczZCTWpWWU9FY0RvcFRFeVZ3?=
 =?iso-2022-jp?B?TXVzaHFzeU96MVFjNEpzYjA5RmFGUHo5UkVFV1kzM205UkNiUzRiVk1q?=
 =?iso-2022-jp?B?SHYwSldLN0NKVnlOKzBNMVBoRnRydDZETnlaRWlyUVZoZVpQYUo4M1Rm?=
 =?iso-2022-jp?B?aHRUMWc4bTd6NEpMWFlwQ1BCWXJhWFp1V1lqWS9tVVNRWnVJZmZoYjIz?=
 =?iso-2022-jp?B?Y052dUU3VWwwSlp0R3IvS2ZqeUk2QXhUanhWUnFXTzB4RjJBNVVoS0JM?=
 =?iso-2022-jp?B?bnRoZnJrWVFxUHJvRmdqbDltNjgyNmMzY243RnRxcy9SV29sNzduUFBj?=
 =?iso-2022-jp?B?eVYrUmJzRGhiMUl6Q2c2dndraThFV2pDTHgyN21YU05PUC9oWHVGc2Ur?=
 =?iso-2022-jp?B?OUJKU0x4Mlc5RGxlU0hkSzFiYkVxWm12WUMwb0lWTTdIVUNSMHBPK3Zz?=
 =?iso-2022-jp?B?N25LdkJJUEJqY2hGbnp3cHdMczZVQ0lKNVFlRlVLaWNRNFJMcThOc2pP?=
 =?iso-2022-jp?B?ZzlnbE10VT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 1rwSOgPukeADlpgJNfeUxVJ8xtvjI7BFIEIV/oFLMDM7rvrJXRGSvPELZM/Hl0f1+o02lDc7fwxS0HQvP3X4T+himWyF64LwpNicAol9pk6ijbvSwdqjHsS1XvmwtW/cC5KdRv0T5KwrN9RgRHhjiG+P6N14mF7ESLiUCzCAXazqSPg1XmxUKSn3aMa8NOOestjXNcqyaBrGanr35jn0Si1/VDOnHyDX2YFFHQYybA8sIBU6uB2rRq3cOFBlrV8A2j0d+FN+2J17uNosL4CYEhJVV4K4drVlAVk5tt3D+sd8GIrYfplN5lhKA3KoaBH+s0bC394M4c/yMRRqNGmq6w==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 983a12d9-f58b-4d94-1838-08df35883e6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2026 06:45:38.3862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: asFPeT851ofI0zmVIuvu0zZ4XNChBVb2FA/QzDJ090HBjTv3GI00bM0ONAVPHAXpXgxuEteD1fSGbm4JzzZToqSWMR6oOoUSojLUiKcrBuOU/yxbtcKZWkzgbUfajUnw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10220
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 29 Oct 2026 06:45:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24564

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2026&mont=
h=3D7&day=3D30&hour=3D12&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37=
&p5=3D241&p6=3D248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/10/cip.2026-10-22-1=
2.02.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB

Best regards,
  Nobuhiro

[*]
Date the data is created: Wed Oct 28 09:00:01 PM UTC 2026
linux-4.4.y-cip: interval 30 day
  latest version: v4.4.302-cip115
  latest version release date: Mon Oct  5 10:29:52 AM UTC 2026
  limit date: Wed Nov  4 10:29:52 AM UTC 2026
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version: v4.4.302-cip115-rt63
  latest version release date: Mon Oct  5 07:16:38 PM UTC 2026
  limit date: Fri Dec  4 07:16:38 PM UTC 2026
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version: v4.19.325-cip136
  latest version release date: Fri Sep 11 08:53:07 AM UTC 2026
  limit date: Sun Oct 11 08:53:07 AM UTC 2026
  Status: late
linux-4.19.y-cip-rt: interval 60 day
  latest version: v4.19.325-cip136-rt50
  latest version release date: Wed Sep 16 09:32:17 PM UTC 2026
  limit date: Sun Nov 15 09:32:17 PM UTC 2026
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version: v5.10.271-cip78
  latest version release date: Wed Oct 14 09:30:59 PM UTC 2026
  limit date: Fri Nov 13 09:30:59 PM UTC 2026
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version: v5.10.268-cip77-rt34
  latest version release date: Thu Sep 17 09:59:47 AM UTC 2026
  limit date: Mon Nov 16 09:59:47 AM UTC 2026
  Status: On track
linux-6.1.y-cip: interval 30 day
  latest version: v6.1.189-cip61
  latest version release date: Wed Oct 14 07:07:26 AM UTC 2026
  limit date: Fri Nov 13 07:07:26 AM UTC 2026
  Status: On track
linux-6.1.y-cip-rt: interval 60 day
  latest version: v6.1.189-cip61-rt32
  latest version release date: Thu Oct 15 09:34:39 AM UTC 2026
  limit date: Mon Dec 14 09:34:39 AM UTC 2026
  Status: On track
linux-6.12.y-cip: interval 15 day
  latest version: v6.12.112-cip33
  latest version release date: Thu Oct 15 09:48:05 PM UTC 2026
  limit date: Fri Oct 30 09:48:05 PM UTC 2026
  Status: On track

