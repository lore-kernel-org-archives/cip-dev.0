Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6234C77B7F
	for <webhook@archiver.kernel.org>; Tue, 16 May 2023 13:11:12 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web11.21347.1684242665072105626
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 May 2023 06:11:05 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.154, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 34GDAvb5000805; Tue, 16 May 2023 22:10:57 +0900
X-Iguazu-Qid: 34trpHMSmaztPedsiR
X-Iguazu-QSIG: v=2; s=0; t=1684242656; q=34trpHMSmaztPedsiR; m=XLfji2ediRYbhyRAkVYis7dzrp/epI7UJFOGsRUMGmQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1512) id 34GDAtVN032366
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 16 May 2023 22:10:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvuHdErlSCU1kRk7RrrcQvQ8ou3ADtqNYiO+6wqqdhyK7ooIVHQe5Ba0OjKCwmj1DOMte3kAa/XL0S7fVa1AA8DCFV5KjzQr8p55Dt/ooZkQGDfJ/OQ6rK3qtlrROqDJBC+5RHeIRSXSKUKNyLP9G9/4buDd8/Mvdn1Si4hsYvSj4SnjXvSjv99C7q0idj3DCfrh6VBpVwQ6MJVqLb7XsK4Sk3BnRy36uPK67ZOXCPbQO6QsLtvgM+qXakTum29Ozyj45ESdkHdVTpGgriQT7Nv9bh0bLFxRFSO3kYqqa2hb0zpxWbMyuwKnDI/R/aUZoC/dBKQibP/gUULvDeFSXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sc/e2C1Mi0ubWfYdK1r+tGUDZvQe5vhlagRYjLe51bY=;
 b=CwtvwLxZQK3DDCle6eMc5l642Q6ia9nd4j9A0jpnSRnRVEWOUBYF554uuv4Z4Kgx6fIEIzhCQUM9aAFPwQcgnjKNoKwF29n1M+nYyAR8cv7BvKIxPCFVEypqU5kHdpdGtF0+fhqkdgsa3NwWQtUCWPWG+I3aoLPWW9Y7USNkJ/XDPFauaEmG77P/d4v2ECdzZJz0a8XwWwUUwvek0O2htOFR88OhW57MQwag7F9Cp0uQuw2kg75lxMCO2eBsdY/awopBxDQKgu9IK0ubW1ILSeMxhFWbvSG9fmmSnvExjpppf6qQFgPTodd/4YSTV/7dCsLbfGrumxYLqWC7bMTdWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <nobuhiro1.iwamatsu@toshiba.co.jp>,
        <pavel@denx.de>
CC: <dinesh.kumar@toshiba-tsip.com>
Subject: RE: [cip-dev] [cip-kernel-config] 5.10.y-cip/arm : Add support for
 access control lists.
Thread-Topic: [cip-dev] [cip-kernel-config] 5.10.y-cip/arm : Add support for
 access control lists.
Thread-Index: AQHZhyaYkYJJH/WfUUqAtF70g0QBa69byMmAgAA63wCAALQGgIAAJ97Q
Date: Tue, 16 May 2023 13:10:52 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSAPR01MB494518FC9E0D570222A9105CC2799@OSAPR01MB4945.jpnprd01.prod.outlook.com>
References: <20230515121256.14413-1-Sai.Sathujoda@toshiba-tsip.com>
 <ZGKVe5ctFMEEnj/5@duo.ucw.cz>
 <TYWPR01MB94204EEB864167B2FB8E0DFF92789@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <175F99E899762743.26562@lists.cip-project.org>
In-Reply-To: <175F99E899762743.26562@lists.cip-project.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB4945:EE_|TYWPR01MB8411:EE_
x-ms-office365-filtering-correlation-id: 97e17515-f9d5-4b2b-5439-08db560ef9b2
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8NdT6m1J/NDA53UK+i+GK/Vm7WSIRyaNnyZsJKapcQdE4KqxcYofGRI+s6tkQx7MB5wsLWGkxvy7Hdg1wbn6F9bxxqyPswvZOXBsRLtPnUh1+oFz9Rq5nZVpAsJ1M7lIC1n62lE9ACMDQ+o9OpTQDJycA0u9YTYcVNcSRqI/5ofz4tqBLdZU1ry+0p2L8SpmGzz1GrG1mi+e54OIiV4V87OpjwhALq6f45YW85oK+EOOvXKscmngYkdzSgQZK2kTs3rVDzaflNaBJbs1RCsu37NGvgWmVLsPLoIkTQS9gYdWRVs65qal7FjxGD2oeiP7lq80RyM2+eWxC9tAsecHccCApWtFmmosgehQ1e6ffEfPCVvaJHHTc8I0eOriUxB+u1aH9i0YL/Bc5lMKC0VIaKNLn6ELFs2H0XYwvsnL87oFHHw+h95lFQYJTChkpDJx0r5dQF8spsn2Y4Bine0KCkzb2T6mv5uBjzNmNuDAqBoGsGC/5oZGpfxNHt/eUwLRccbioBIAWWZfnt1CNajcMLC2+3WUH858crG622G7IAUJlxlGwQK7l7wkbDARCrDYMCwKUPg+cAChNA45eh4I9HUnKb+c8bg/v/c+ULOtio9ZPbqUN/Z+57d1bbRRRYD7
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB4945.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(451199021)(71200400001)(55016003)(122000001)(38100700002)(107886003)(186003)(6506007)(26005)(83380400001)(53546011)(9686003)(33656002)(2906002)(5660300002)(41300700001)(52536014)(8676002)(8936002)(85182001)(110136005)(478600001)(38070700005)(7696005)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(316002)(4326008)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NG9pOEJMQW5JQ1IvMlNzSDNRVVFvdVJXdWphMVRES29DZWd5NjZoM2d3?=
 =?iso-2022-jp?B?NXJhNUdLVC9sZnVkWFY5Znlod0tmMHRyaEZ5OFpnNExUcTlXMXkzaHFj?=
 =?iso-2022-jp?B?SmVCUFZQeUw5czlnQkJzSEtVMFVsRy9JUXk4SFQ3dXB4c1B0SlNxNkU3?=
 =?iso-2022-jp?B?Rkx4NW9QNi9TZjg3RloxRVlwZ2Jva25lS05LbnU0TXFQZXNvNTVXOGVH?=
 =?iso-2022-jp?B?NWgxLzkzb1VrYTgrN0NjNTR3TkhlaTdBMVhJOEFFZnNBaHBRNHBTZHIx?=
 =?iso-2022-jp?B?N3dwNmZEMFQ4dFhjMHVaU1ZpRDdSZ3E2ZmdRYURDNkQ4c1BYc2RaSVdi?=
 =?iso-2022-jp?B?eDJidXZhUUdDTjBIbTVQaWYzNm8vRUdyUlZVZG5iNVN6VFZVUEZ4bjF6?=
 =?iso-2022-jp?B?cTdGRm5NYW8zZERTb294WHBCZGJQSlRpQjBJUVRqU3VPbVNVZTM0Vklo?=
 =?iso-2022-jp?B?TDJLSWdSVXdOUDRwWmtYc1FzNHNhWU5lQWt2TVU3WU1RWjVwK2pselJl?=
 =?iso-2022-jp?B?WTB0dkpnWkpJTVE2SkRnWjY2dVEzNThubzJSTzYra1EzNnZSTk1RR2M5?=
 =?iso-2022-jp?B?QlNIY0xOOUFJbGdNNEQzaHl6TmlYVHhuYTBDNllhNjMxMjR6MzZHRCty?=
 =?iso-2022-jp?B?QzBvY0I1NGI1UGViWUdCdHJoVklLTnd2d3dXblBGdzFyUDluY3ZWR2dC?=
 =?iso-2022-jp?B?OTN1OHhPc2VBY0w3RHRQVzMrSHA2RDlpUEdKeFF1M0phMnZ3MGFGN1JV?=
 =?iso-2022-jp?B?RndXcVMrS0h2SnUzcDg0WUVkMnpqUGJ4MUZDSERHd1RERjV1bHFoaVJn?=
 =?iso-2022-jp?B?RlFIdU94ekVtdVlaN1UzaTBIeUhiN1hOWHI5SHBWNjV1UXNnS0hpaEVk?=
 =?iso-2022-jp?B?NGVnTWQzdU5IVnZGRFdRMGlEclNkejhOQlJWdk95R3lGK2FQZ2JsbWNr?=
 =?iso-2022-jp?B?Um91MitwaUJwMGJSL21BcnJhek5QWGtQRlpWWTlKeHlyNStLNWZJRzhJ?=
 =?iso-2022-jp?B?NXVLWGpLVUtZNXFOSGgzTjV5L2QyWnZUbnFNbUNiemdiVmprbmZJU2xw?=
 =?iso-2022-jp?B?ZHR6UTluZUUrek96SXhzdXNVWUZtWjg0d2xiUVF5MkkvTEZkNkQrdGYx?=
 =?iso-2022-jp?B?Q2Z0c1dCNWdleVREMkYrY0NNaGkwWjc3V2xBdnY3WlpXdldPelVURkQ1?=
 =?iso-2022-jp?B?OXJZVURXY1E2V3BTdGlTSjZQOXZ4bGlBQmU0NjUyU1B1YmVLRHU4Mmkv?=
 =?iso-2022-jp?B?Q1Z5Y3VSWWdROWcwaFlmZ0hDY0M0Z3BxSTNvU2x5RU1QT1dJYUUzM2VI?=
 =?iso-2022-jp?B?TDZnNUYzcUdmRXZwUjRhU2VSY2E4ZWFBdlE0Q1lQS1hxWjQ3RHV3dDY3?=
 =?iso-2022-jp?B?bEw2QmxSbk0ybkZlY3NlVE5YaElLdkN3SExJdElOQWhvN0FHdnBqUENn?=
 =?iso-2022-jp?B?M0VhQUpPb0NGMzIwNjN3cUczUklHdnB6N2g4cUpLdGNNZnAzQWdIbjdp?=
 =?iso-2022-jp?B?c1NsOFpRVkIrK0YydjFQZGoxV0JBblE4NnVsQ2JML1VHNXVUQWdTRGpM?=
 =?iso-2022-jp?B?UkF6U0s3ZW5Pdncray85cHVSR0pCZ2RPT3IvRlV3ZlZ6U3V3TW9iTXBv?=
 =?iso-2022-jp?B?UitUSUtKZXZIV1ljUlcwSWxxaGFTMzZnQ2UrV1dDSEJhblZWL3I3aE1z?=
 =?iso-2022-jp?B?TW9ocEpkUDIwd0ZrWHppK1NEcjI1Ri9ncEljK1gxckU4WTdLTVFYVUMv?=
 =?iso-2022-jp?B?U2xtaldHRTMveDVENlpMNnJ1TjU1MkJnN1hpcnF1SlVveHBKV3JjSGpk?=
 =?iso-2022-jp?B?Zk5zbGp0bDBiTFpDRG1qMkljM1E4Uldsa1lIMlZBN3RtK3RVQXZGa1Bv?=
 =?iso-2022-jp?B?TTBzaUsyTWlmZG9ERExKU2p4dDZtYjNXVWxaUzY2VTZGNHRaTE1UbHRO?=
 =?iso-2022-jp?B?a0hYNHZ3MU0xVS9SK0ZubVo4aG1RUm1yU2JTSm9Mb0xhVVd6dXVIZitj?=
 =?iso-2022-jp?B?N1JBd3NrRGFFNWpOaWthK1d1OWNZTlE2UlZ1MEU5T280Y2tETUI0bndh?=
 =?iso-2022-jp?B?TXhPUlIrQ0piNzNMV3VJY1hSUXdFSDBuM3lGM0laYXV4Q2IyWDA5NVFi?=
 =?iso-2022-jp?B?Z0RYaUZmdDF3QmRCck9uMnMvekFmMGpoOVV6bDRWa3B4R2xVNHBSNHZK?=
 =?iso-2022-jp?B?Tmx5S1NkSERYTStHU2NVV1RtMmd1WDRzU29Cb0s2Q1lVZlg4MUFpeFo5?=
 =?iso-2022-jp?B?dzFsNGtDRGQzZVp1ZU9ROEQvUzJjbGhLbDdXTEV6aDUyMFhiYWxEMzF5?=
 =?iso-2022-jp?B?ZHFTMy8rYXVjMjcwVzluaDhwOGRjZFI3VUE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hxVEddfnmQhgfXJeQscLVpyPZeYifj8Ak8g10Mw0CuKwreHhZpUm6P6+bES4biUnREenYO3qfdZcBZ6F5umbvlTf7ERirEyiB+3Dn/hWlmAiWTbstO/tiigWCoC45lqICYaMJM0/ufcq0zFCUlieFjP7YVNXJRqJpTuRv08PlSwmKs2TmO6QzwhpHtcDnO6FF0dSaiU/AbYdRhnG6UWHlmSrGmekcMckrW92G620YDzYzAlxH/INVXdbFHGvb/pQSz6s7bNmv+LNWUszh+YahG3YR7seKTJzevlatG85QzSnQGi1zN60JKIquoxgafKKtEZU8GeIjZvE9S84MVWJ7jWvXtQH7osPq4sYpIDM55ndnodqWi2A80URY7pTxMJYl3MlGyOPY4Cm92Rqrrn87ezZQnK43GYNmUiKZ9ggcJstW/UnF5E2bT7UeI8SaIIpz58YsAvf84WI4VjEktyv6HCXymIhMiAxrQ977gy6jC+2+5Y9vZkZcwhL+JxixbLJPVbdZA8rQ6Qbo7c7ypF4ld3MGikC1Lyv2LtoMIe9GKEpRMxttPyymsW9Mr6Lwqg2xxi1pxCYGnS8eaDaFA96RhT/6Ulh8D9unqfwvWkBWexfNW12SfEFmrVkfkjV0vlBesljT1qvrls0PCiRqWRE6i+CLVfzhhKsnQDKHNFetTBRWoGecAc5UDjZv89mzxQiC5ZCyi+kl2RUsn9RfNuFlCm5snY9vYoNRTOiK9RKP/jJnszcuSPUxZHbV3fsz1S9UATne26Koy9lEn892EUVxijub5bEiUJVD/FN83TUsh0oPcEF7ZZnyCc1YsFKZlhH8WHaYWe/GBB0qOE4XGXjEA==
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4945.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e17515-f9d5-4b2b-5439-08db560ef9b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 13:10:52.1571
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dRpCG+LB4LW/bISsX0xqfhCNzkoDXhs1xsS+Tra+gJ4gXxwymfT/2XDVjRn1mOJFRgxFrbQufwqtQtFpgw4Ndc4dENnz1NmMhEBXLNgWma0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8411
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 May 2023 13:11:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11468

Hi all,

I apologize for the confusion from my side.=20

Actually my intention is to add the config for acl package in the IEC layer=
 and it is not to introduce EXT4 file system config for armhf, it was added=
 as a dependency. Currently I am checking with an acl config (CONFIG_EXT3_F=
S_POSIX_ACL) for the already present EXT3 file system configuration. I will=
 re-share the patch once the outcome is positive.

Thanks and regards,
Sai Ashrith (T S I P)

-----Original Message-----
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of sai.sathujoda@toshiba-tsip.com
Sent: Tuesday, May 16, 2023 4:17 PM
To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I#T=
!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; pavel@denx.de; cip-dev@l=
ists.cip-project.org
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshib=
a-tsip.com>
Subject: Re: [cip-dev] [cip-kernel-config] 5.10.y-cip/arm : Add support for=
 access control lists.

Hi all,

Based on the discussion, I got that we need to remove the below configs in =
5.10 arm defconfig and we need to just include ext4 configs. Is that right =
?

CONFIG_EXT2_FS=3Dy
CONFIG_EXT2_FS_XATTR=3Dy
CONFIG_EXT2_FS_POSIX_ACL=3Dy
CONFIG_EXT3_FS=3Dy

Please confirm.

Thanks and regards,
Sai Ashrith (T S I P)

-----Original Message-----
From: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I=
#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>
Sent: Tuesday, May 16, 2023 5:27 AM
To: Pavel Machek <pavel@denx.de>; cip-dev@lists.cip-project.org
Cc: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>; dines=
h kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.co=
m>
Subject: RE: [cip-dev] [cip-kernel-config] 5.10.y-cip/arm : Add support for=
 access control lists.

Hi,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, May 16, 2023 5:27 AM
> To: cip-dev@lists.cip-project.org
> Cc: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I=
#T!{#O#S#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; ashrith sai(=1B$B#T#S#I#P=1B(B)
> <Sai.Sathujoda@toshiba-tsip.com>; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC O=
DG
> Porting) <dinesh.kumar@toshiba-tsip.com>
> Subject: Re: [cip-dev] [cip-kernel-config] 5.10.y-cip/arm : Add=20
> support for access control lists.
>=20
> Hi!
>=20
> > From: Sai <Sai.Sathujoda@toshiba-tsip.com>
> >
> > These configs are required for acl package to work which is used for
> > IEC-62443-4-2 evaluation.
> >
> > Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
>=20
> Seems okay to me. We'll need to apply similar changes to 6.1.
>=20
> If we have ext4, do we need ext2 and ext3? IIRC ext4 can serve as both of=
 those.

Agree. But IEC-62443-4-2 may require ext3, etc. I don't know the details of=
 this...
Or if we decide to only support ext4 as CIP/QEMU, I think we don't need to =
configure ext2/ext3.

Best regards,
  Nobuhiro



