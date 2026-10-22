Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16867.1792648925977935534
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Oct 2026 23:02:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key2.smx header.b=JnARN6cb;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=1792648923;x=1793858523;bh=
	wt+rYfEZwc0Ru58KxFarDyQXIAcRRfjX9R6GbOPFGLU=;b=JnARN6cbzDpYdOeB2Pjt5YZ9P4Bv6H
	yvHP+t+ohOIdtGvynoq2VN8sEma2GyA3664I3+CVXlN4qSxLWfJ9ho5QGHaRDed7DbJ0g26ZXHT8f
	qb1wmLgC1rKdd9tshctKZ0B0Vg74fGG8l4YfqNNRNjvDaCAf1J1pfSSHWJxH5lQ8TK4EYkv0nFOZy
	oLz/zvPK8hJXJAv+1P5f2M9jrlZe6Zq2jQRzYlGqz7RmaXHX7kWB/T6iGeOS6uRTv0nSFswgj887m
	wE/v5iWs5GJWADy0W6ggDBzwcfaric/H4HnYfLMYDy+IbnIeC6RjDafYNWERmpcDlRU9JX4fvBt3O
	FHRA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 69M622Vl280086; Thu, 22 Oct 2026 15:02:03 +0900
X-Iguazu-Qid: 2rWgtwVk7K3XpEqfiO
X-Iguazu-QSIG: v=2; s=1; t=1792648922; q=2rWgtwVk7K3XpEqfiO; m=+al+74Bu4xjgicqCubxI6QLu6zIiwIcBiGRjFwFZFms=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4j9Fsk33bGz4vyw; Thu, 22 Oct 2026 15:02:02 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzRm6itPsbLQmuCEg1/WW5zgBTG2mJJD+uzT72C5XaodNcmFj9Tc5ov007NIN48c+3I1Q2yTOIM8+HhNP9OWQkjEVuwLXKM66DZcNXmycdQOp37J7YmsBFO79giJ9JjkCOqB2xfgVwVDNkEumswEC17AdgN1UOyvHTmT2A1/12y5Iz94VI7Nsb45pQcZK+lkD9+Rn15ahoBoNtCUzlwXfh8MXNlHZMUWewezcYj6xuGqktpE7j+UiPb3QHUOhUYTPy6a0UCOCdjqAo6ZEqHA2j+jNuBMRqVRvofN/sTnyKlY1raevT9fW9cqs0MhQ/Ksk6Ytj8cCSW1AMin56OLWGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vr1g1TUYUgQFOlvqd6vRY5wlgXcoTcvueBW8wPGhz2w=;
 b=Fp2svYrzXftPS7mAf8xh+v2BwdDW14+CTfaR4LT70Hp7cnrGkYdIZbPddRHXxolQ8MT7uKp+FJe30JptEK0ctUmrNaIj1FlcGVj2zn5sg/tPMNl2yOlXblkv+EzJRcPwyLpgPrCnh613URnuEDXJhE7IIdATjRgobIXrVoRgWAGLV/6+Kor1nQpmFz7l6KiHNutjsF2WYrYtgiSOF0dl2APbOEP/LwH5RNOcpvYaIkqURf6VCQEm2Ts+KDQFjdVEOPo6EPK3gnv8kzU4Vx4SMHb2Tj4wpjS4W8qhaXRvZ/FXPpZT3gwLoLqrhhTz8O1P142G5/FQHcIQClAeDqQmSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
Subject: CIP IRC weekly meeting today on libera.chat
Thread-Topic: CIP IRC weekly meeting today on libera.chat
Thread-Index: Ad1h6oX0S1OoHbQnSjGP8c+k7Jf+QA==
Date: Thu, 22 Oct 2026 06:01:59 +0000
X-TSB-HOP2: ON
Message-ID: <TY7PR01MB14818BAD0950E4626383BD086CD652@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS9PR01MB16233:EE_
x-ms-office365-filtering-correlation-id: d9405cda-5296-4c2a-b0c6-08df3001fc8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|38070700021|261009223027099003|11063799006|10067099003|18002099003|261021135927099003;
x-microsoft-antispam-message-info: 3hQ4Ci9nfckzIQDoBAIUADTcT0xPVqhGTvHrv8z8G0Zqp5UpRkdaZ3lIu2KpRdp8w0qrzmqAbdpb18AC+8WtEsQa9q0gkdCeGt2jz8ZahrPhLZ+5RWvieK9oN3ugGOZ5/cZiEKjDs0/fm53Gxt1ZE5Ma/GGZL0ektfv2lS3qporafR0qtYEOBfszJBU/kvc5LQ0ExrzTuaVQV8LxiKbuibIjDVpuqFR0rANTcUT4grdU44zf5NJy8EA+EvZzHgpqgVekYKfbv2+e9jht4KlVUcyjBGUM7al2txr+0SrktP4eJ2hHi/Zq7rxHT/QigFQGOy+MpCDKyBsdqT8Lkp2i5TAOf5vPMAjhk45clIE9+YOuTaE0cMUp7+0xlJBme3vHGJNsnpDQT+NVKlLmKg3/0rPZlZDGU0E7t34tp/IknhOCTAsosySlZcTS/VoVJC3Za0tLOJZFwZpqvt1wu6XUpUqecx82e5yK+2tPP7PMmOBxAQofcO0fjWAnVu3I39m5dZM7Zy0+UKVn5sLA0wLxzRO4nliYLGimBg0PCL3AP/ue2SMwIW4HCtj5eyBDQKhroKraWWuF6k5WowmLFJ5zAbeiu2ZWN4tzd9GFQCz4xVekHAgpaTBMiCljd7uZZF17REaDG5MgfR0a0+ahBEeCe0Vc0xTr0mzTe6+3eKlU1C8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(38070700021)(261009223027099003)(11063799006)(10067099003)(18002099003)(261021135927099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?Wmg1ZzdnS2dBQmZpRkpTMEFYQ1F6bFVVcG1hVFArb2NRdE5KYnFaMitm?=
 =?iso-2022-jp?B?ZEJVZFhMUHhsRXNVVjYxeUIwWSs0eFFtbUhhd2tBZGFrTEFQNVF6VHFx?=
 =?iso-2022-jp?B?V2U4d1JPRnYxbnRHWkh6RFJ3QVFoazQzQkZkdFR3bnM5VWN0YUtHSUNs?=
 =?iso-2022-jp?B?V041bTlvb29OWWE5UEpLK1JnWHMweGt1bDF3LzRHOGtuUXVjYkQyZnBX?=
 =?iso-2022-jp?B?OHFwc21odUFUZ1crMTEyeFFvK1haUDlCclpGUm13ZmJOOHVDVHRPTHpk?=
 =?iso-2022-jp?B?Wkd5NmpkT0R4QjdoVFREUk9hOU9ZUVZJYTFXUmlPZ25lNUxIUll4Wm9N?=
 =?iso-2022-jp?B?bFZNL2l6NVFOSjJDT2xJTFBvTGJIOGdaUG4yQjJLR1NKeDhSRVV4OGRq?=
 =?iso-2022-jp?B?YzRFVDZjVlJCdEpPNjJRa3UyRVFQWk13cEc0N0t5L3ErZEZlWTVoWHVi?=
 =?iso-2022-jp?B?eGxsVGNSOVBJZEljdTJkYndsdzdtTnM3eXo0bDM0NnkvWUErOVFTVzM0?=
 =?iso-2022-jp?B?eExxTnVKWmlha3NRZUxtU3hmNDY1WUVPYjJFaGR3NFRJaGNXaENWcjVU?=
 =?iso-2022-jp?B?UzNCMzNOS3VCek5GK1ZXT2xsTzBLa2hMQUdMSlhkNk9GWHYwbmFXM2RX?=
 =?iso-2022-jp?B?cS9pbk5NZEEwOFYvUTBsa3ZNaEZjVmovcTZkNDhway82UEJsU0RvdmMw?=
 =?iso-2022-jp?B?NGZmZkVuSVk4YlowR0hGcTFpajdSQ2hGbGo3Q1BCZUQ2YW8vYjMvM3Zl?=
 =?iso-2022-jp?B?aytWMERJL0s3S0RoM1orU2tNenY4NWVJVUQ1LzRrakQvMmZTK2lpbTNm?=
 =?iso-2022-jp?B?YlhUbnUwT2t1bjlsckxNZUcwVGMyMzFQR1BOOGQ3SW81bjZsSGswZWtJ?=
 =?iso-2022-jp?B?L2I2K0tpSjR6cnVWdVdEdzI2ZThrUEZjVmF2WFVRanZ4SUptb3V1WFd5?=
 =?iso-2022-jp?B?a2w0QnlPanNST2x1RUhaMVMxUXVNN2Z3TXJ4WnMzck9tSmU3QnU4N1lj?=
 =?iso-2022-jp?B?R29pWHI4aXlONmhIQWRjWEhLVGt3Z0lyOVQ3RVpySDNXcWZQYVF0TGov?=
 =?iso-2022-jp?B?dlViL1haR3Q5QndScUJEZGZBaWRqa1Q3WXpUd2hjaHFlTWFCVmFUMzNq?=
 =?iso-2022-jp?B?S0ZrMzl3S0czb2xWWWtSa2VsTmhYdnJmYWdnUXFJa29NVktDU1Q1dWdw?=
 =?iso-2022-jp?B?MTYwbmNEZnZlY2tweFg5Nkhka3Vna2hicG4rSDl0N05pdXgwd012K3hM?=
 =?iso-2022-jp?B?YlRsYzNRZUp3QW5ENCtmd2VuQ2piQmZjTXFzY2pvaHVNZUduNHpQSG1s?=
 =?iso-2022-jp?B?NG11ZStRbXFNckhReVFETHdoV3RqdTFEV01PMmhiWUVQUTBzck1iQkxo?=
 =?iso-2022-jp?B?azIxenhFWm1xQnRJVzByYWhUYkQ1ei9uaEg5MVNJdldwSTArV2t5YWVz?=
 =?iso-2022-jp?B?NitidzRSdnQxSG5UVnZPNHVBVDJUU2FCVjFiTzN6RVE4S2VwL1Q3Q04x?=
 =?iso-2022-jp?B?QTU3eG82dkcvbFdkbUVVOE5wWU5jY1VFd0pJeDVxTTdTSHExM2E3dkFJ?=
 =?iso-2022-jp?B?MFZvbUFJUGVqbC9iYmxERFVRMmdGZWo0Z1FHbDZVQjdvS0UrM0h5bHFQ?=
 =?iso-2022-jp?B?aFFuTU9LR29zTXFBRElyd0pzbURXT1FmY1JUYWwwWHdzYktoTStMQW5x?=
 =?iso-2022-jp?B?em41aDZONlBGS1ZFUHlzZlNuamh2SlFpZzhZeUdFWGlkV3RoM0JlS2th?=
 =?iso-2022-jp?B?Q3IwTGd3Rzd2RHUxT2pHenRBMzN6SWw5WHFyUnN6T29Hc1FKMTZHWWM1?=
 =?iso-2022-jp?B?QzQ1Z2xSRzVyMFhuekZxNS9jWDhiRWhLRmNwb3kyc3BwM0RpSnNTZVlZ?=
 =?iso-2022-jp?B?dDYyRmphZGp5M1E5aSsyQ1BSSVNwYTVkYkZhZ3dnMHA4UDFaMVpWaENY?=
 =?iso-2022-jp?B?WkpGVW9ubytsc3NhNk5wWGUwcHZsbktuc000aEdtVkZiRHI1ZzAzS0oy?=
 =?iso-2022-jp?B?VjFTUE44S2ZtOWlOdm9qdmlMRENQWlZkTkk0NFMrc0ZlYXdjY2x4eUtL?=
 =?iso-2022-jp?B?UDVFby9xWFpscVVubFdFblRVaHdYS1l1WGhUVzhyVStlbnNFSWN2YW1U?=
 =?iso-2022-jp?B?TVBVdG1XMVBRZUJtK1VDRGpJV0hFR0l0cy9TejVtSmtPcXJERGdWVTcv?=
 =?iso-2022-jp?B?RlZ6dXNaK1Vja2hiYzAyTy9rY0tmbUJObGVCUVNvNCtwdGJsR0VNeDBl?=
 =?iso-2022-jp?B?b09URzJrVldlWEtYcTlWZ3Bmcm0zWmxrVmRzNmJiS0ljZ05ob2ExT3Nl?=
 =?iso-2022-jp?B?UU91VmNtVTlnREplc3FRUzd5Z3ZsaVJrQjZPdE0zOWZyL0ROV3FLeDNJ?=
 =?iso-2022-jp?B?SG54a2JrQ1hOSHZMS2VqNTRZRnRGUG5VemQ1L0E2SlVpS2JqdVNablBO?=
 =?iso-2022-jp?B?U0hWWGRKRGZmUnp4UGFNNjdIVmtmMTFNdkcweW94c0tUcmx2bElmOThE?=
 =?iso-2022-jp?B?RCtEMndmTE9MbDNMSldHOEtyN3o2K1pzREhEVnVsL3Q4cisxcVdOOS8x?=
 =?iso-2022-jp?B?bXBFYm1sRT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: y+VYFMfucLSLzYyspl/OBCDq02qKExJT+bdPQAkmOu5NYwdnH2WO2krzl+Kga87i1COXBtB43Nnqqox48aVgiEbpg8mnGL6h+WeJB+6Tq87zARx+AxPkBLvXTQfkK12hcLGnVX1tVeSMN5z5GIraHGt6Cu2EkOqEvCWacPSiY470fDz2jgrKqB9FSMsFrLs5hkxGzco6dncnh3+EmOgNUjARx2smLjsDov+JWiGU13Atd3LIk/J6ne09Ogf9lIKtdiKemWDUnRKY/K2zQ9fRrq1WOIp1gzVkLfP7DtgxeEHl+UDdlj0RTTOh+ADNm/wbTkOCbcjtcTv9sho0wskMgg==
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9405cda-5296-4c2a-b0c6-08df3001fc8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 06:01:59.9811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4gOo9f7/uS0A/PPgo0AvLO2VI5U71lkajYvbIt8tb2eLLPQmYqx6Iwcqq2mmjg4IGJIoJMgahqehMRcElZ1EDzseFC0oParJuRoQbLkI3af/QRx9jjT5B4uwdbQAPtnI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16233
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 22 Oct 2026 06:02:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24508

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6697/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2026&mont=
h=3D10&day=3D15&hour=3D12&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D3=
7&p5=3D241&p6=3D248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2026/10/cip.2026-10-15-1=
2.00.log.html

* Action items
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
  - patch review workflow/coordination

Best regards,
  Nobuhiro

[*]
Date the data is created: Wed Oct 21 09:00:01 PM UTC 2026
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

