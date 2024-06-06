Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A6DC25B75
	for <webhook@archiver.kernel.org>; Thu,  6 Jun 2024 11:48:52 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.12266.1717674521907337367
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jun 2024 04:48:43 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 456BmURq901519; Thu, 6 Jun 2024 20:48:30 +0900
X-Iguazu-Qid: 2rWhyQ028Z5z52b5mr
X-Iguazu-QSIG: v=2; s=0; t=1717674509; q=2rWhyQ028Z5z52b5mr; m=dcwWU0jVUpQDZcNPWxahpBmLIbOuFIUaFVpTQKfJGCI=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 456BmSp14178473
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 6 Jun 2024 20:48:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/TLg8ANDiz08KPX94xRZ4TptnnRwQLJi4+OLyD0+bF9YMDJA5ykCMiEpyKVtSkqNJRnDwEwjBePD7lCjxR7QslMiFcuAVbAeLCtwgRSuJ59e8YLIKISkkZMWW21L+qtYfTBXON2QdM8t9nySUWK7cY4tj5ahUOiIuVNM1ztw/OkIMdgd0ujvIDNDmEg+5VfdgEgXJFotSJ5XrXOAumRDSBF1PptBTAlW/JNyCiK+nKZLt3PsheN0xnvUWq1tp+07QKwX2ztQBskL4bz8NGHBaCF5gbQnVP9MbEZw/QiZLycoKwiuxKPXuKZO0ojJToyBuMmVZnDlHHs3TROaLvKUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qcy72Y7u/EbjWfQGPj46XY2UybbOOQkZNfOOy7uTzWI=;
 b=Zw/MvUNmeazEkFVEOSIqydQpjyKCpN0bJDBslKsxnzaNSEXNZs48RKvLKsf9xJtrEXag/9eVe+sl6n4g7pjCPmfW6YWdtP7BdyRYhN5PAJNmWcxdNuQz6hlZH6Vs/9go/3k5l+DkuZs6a1ngk3aRfNKg/gzaWw271yF9QgUmk7f9gpQag1mJLDfa+e5nEpJ46W8WvqLbSvGd1hjR4V4zl4cauGMuCGLFevJKPrLYEcrhKJLBEFTfKJ+L3jchnPZ3oO3jVlDhN27CcRyliNyLRxyQ7XtwzQPwlTBMpHBLILo0WVnXb9DoAi59Cp6gGX9T2cwD9FqQVaeMQFgpK0dbNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <submit@bugs.debian.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
Subject: syslog-ng.service fails to start with empty var partition
Thread-Topic: syslog-ng.service fails to start with empty var partition
Thread-Index: Adq4B0CkOtP87QHFRJKDlOTyVBhsGA==
Date: Thu, 6 Jun 2024 11:48:26 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB61031FB54CB5551D9013BE58C2FA2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYTPR01MB10955:EE_
x-ms-office365-filtering-correlation-id: ae61fab0-4a93-40a4-f1cd-08dc861e9390
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?N3dZakE4ZlZBL1VIRkFBUHVlQUlzc1JINSt2L3grRkcyeHBnRkExTFhV?=
 =?iso-2022-jp?B?Z0tjdjJ6ZytFK1FVRjdzNW9QamlSQ09CYm5GanQ1R0d3dWE5K2UrSi9Q?=
 =?iso-2022-jp?B?cFgxMEI1MHdEcTVOR0twVjM2d3ZWWnI3SGtpQ0NSa1R3Zm5WQlpJUXVT?=
 =?iso-2022-jp?B?MXZaYmRndmlVRmRlTkdNa2l6L2kzSk5DUWxGbmNlOVQ2V2E1QU5uK2po?=
 =?iso-2022-jp?B?M25TWUxxVzA3TCs1em00RXBTaVRCaDZUUDVad0NVQlNpcitZeGZIYWZs?=
 =?iso-2022-jp?B?V1J0Q0cyd3IvOW1YcVh5Y0VkZFA0MU9salVBdmJpbWEycTN1UUFLWXpa?=
 =?iso-2022-jp?B?c2dVRWRlb1YrWFRjd2dxOEp6ZHRXVGRDeS9YUXVWQnY0dndEaFdpcDBG?=
 =?iso-2022-jp?B?dVYrR2JxN0RhU2tOZjJaOGhvUllNb3VZZkJVa2daSG40VGtUeG9lVWd0?=
 =?iso-2022-jp?B?NTNhd1JCZWNIK29od2VDdFV3Rmc2NGpJazQ2aTlXWm13VXZ0RVZrMzZI?=
 =?iso-2022-jp?B?Y01DV3lKUXVSUjJEdVBhRjZqSkRUUHhrQldrNWlhZmhDZU4xRmVFMGcx?=
 =?iso-2022-jp?B?NnJHdDU0d0hhU1VIZm5aeWJDMXBKcldSUnNhcjhKQmpvRkJqNzBvd3dB?=
 =?iso-2022-jp?B?VjhjckhWMjhKVmZNNFZrT1FUbmdsL1NRS2FsSVdQOXZpQ0FkZWJta296?=
 =?iso-2022-jp?B?ek1rNE1RREtua3lMNWNlT1BaWGNGZS9YMERETXVXSUoyNEszMnJjRVY0?=
 =?iso-2022-jp?B?bU0rL0czdzZ2cWIvNkxzcTlQdWxERTd4ZlBlNndIM1lrbG1oM1Q2TEV4?=
 =?iso-2022-jp?B?UTVITXNqYkVrcmNadG9KSFBjQzg0dWtaTHBpVWtnOEpGdTBVNENFTm4x?=
 =?iso-2022-jp?B?MVFGbmh6OTl4QW9SZVpJbTBCbHJhSitzRWNpTTVjODgwTlFJWVdXcUMr?=
 =?iso-2022-jp?B?Qlh0YlJIWExnQ0tQTFd3UjFQSE9BN1VIc3d3cEVUVXNQdCtRVXBBeU95?=
 =?iso-2022-jp?B?eEV6ZWZUMnFleFhjYXozRHBZYmM3T0VFS1duOG9xM0dWVzRSeExKYUxK?=
 =?iso-2022-jp?B?V0oyTS9WQWdISGRqRXFtcWk0TUJwQWlGMlNqU0hXWk8rMmt5Z0R3NUJi?=
 =?iso-2022-jp?B?VHpnRE1EMXNIbnZIYXowNVNzSzBkd1RadmZyYmVRYVZOZDlRdk1HejNH?=
 =?iso-2022-jp?B?OHlOaVVqRVZ3Mi9HOVRSdDY1OThpbmJycnZaR28xSGp2SFlWekdKMXhR?=
 =?iso-2022-jp?B?WkptQXdvUUp2WDFPeEhCd2FsUW1jL0YrbldES1hmOUh1N2l6ajQvV1pY?=
 =?iso-2022-jp?B?c3JaMVEyZjZ5cU8xdFpPODF6YWdNeVM3VWMyaEF5Q3JMMDFwZ3pQdDZ4?=
 =?iso-2022-jp?B?SXhHSEkvY0I0UVZpNW9nYlZNK3RxQmNvQk8yVDZIcXRlRjJqTUZlNjdE?=
 =?iso-2022-jp?B?cEtYTGJJLys5YllaT1BzeC92RjJJVEdMdTkzNHhsdjBJOHBHdUtxSm95?=
 =?iso-2022-jp?B?dFB6c1hOWHVVLzVQRUxQS1dGL2c4Yi9VTWZ4c2lsUlNGck5TKzhJaWEz?=
 =?iso-2022-jp?B?dlZoNmh2bUZYby9oT1cwTUpTZVFhTVlvQThIaWdZUHFjWWUzR1RWMHo2?=
 =?iso-2022-jp?B?UlFZMzRyRHMwZG1vU2hDL3QxWG1VLyswWCtHSCt2aDd1RGpzSW40cFlU?=
 =?iso-2022-jp?B?cmQ0NGFjYVVuWGppM1VJM2xCc3dLcFRVTGYxbVkrdkFyQm4xKy8zRFQy?=
 =?iso-2022-jp?B?M3hQaDBESGZWSmNYclo0UjZSdDEzaFhNd1YyTjlhb2VsOU13bXNpWUpD?=
 =?iso-2022-jp?B?WVFET3NKU1JMdEZsS3BRSEVyNVJacVBSeHhUMVJPR1Q5bnRRWWIrbjBa?=
 =?iso-2022-jp?B?Qzc1N0NPbmFIS0tqQ3BVdmNlRktXZVEvcXBlUktYZk1tY1l1V05NRG13?=
 =?iso-2022-jp?B?NXRBTDIycDdyL05oNUl1b0VHMnF6VkdYQ3NoVU1lZGpueExjZjdJUExt?=
 =?iso-2022-jp?B?VT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?VVpUcVNyaVc0K1cweitoWXFUUmpJNFFtR056a2RJQlNZU2lUZTRDZHZl?=
 =?iso-2022-jp?B?dUtIbVlzcnlGMUdMeUZDV3RCY2RueDgrY1psOXVMZ0t2UzBWTGdSMkZP?=
 =?iso-2022-jp?B?TTBUWWhnNGVyY3JGazdndTQ1S2FtYjBXY3AydytZaG1QU0I1WUFXVENy?=
 =?iso-2022-jp?B?dDR3NVo3RkhzaFhqanRFa3Y2dHBZSWFyTUV6N2FzZ2Y5RGlGS3VteDA4?=
 =?iso-2022-jp?B?Lzh6ZVpIeHlUUzlhSHZ3TE1yZXlIcGlzblV4K245YTE2dmRSN0QrcTJy?=
 =?iso-2022-jp?B?ODFUY2JJanBRL0hJanBuQkNhZkJuTVhQVFRqVHFRVkFhVmdzTjNmd3Er?=
 =?iso-2022-jp?B?RmMwdEdzQzJNZ2RTMkpJSC90ZG9ybGxiYS80NGE3TS83aUZCWkVPYkxI?=
 =?iso-2022-jp?B?NjZBQ2xIVFpsM1kxRzlteTZmaXV1S3BKbnQ5eVFNeXM4eHFUbFhodVVY?=
 =?iso-2022-jp?B?M3FjUFdaMUsxTUp5UldQMVE5Um52RjJ5Z0VVckFBQWJhTThxMmZhT3Q2?=
 =?iso-2022-jp?B?QlRkRjZqSlZLZEpPZHV5bmppbmZTNnRKTWhiZThZb2poTGxOTDd1TFpP?=
 =?iso-2022-jp?B?VU9jcWgvaW5kSFlmbWdvS0J2Y3ZJcDl5OUVDZkd1Y3dxVXgzdXpHMU00?=
 =?iso-2022-jp?B?RGFXSEc4M0xDTVJqZFhvRUxRY1pIYVJxOWhzSmh4eERvcmRBaU9FWnAv?=
 =?iso-2022-jp?B?N3Rkamkzc3dObi92Z2dxRnJZc3BkNVZKbm1HTmVSYWp5QU9JS2ZDMUdQ?=
 =?iso-2022-jp?B?RklQdDd3di9oa2RFZlpRYy9XWVhsQjN5cy9Fd3Z1eUNLUG4yWkNsaktT?=
 =?iso-2022-jp?B?Y0o1RlovRDg0WWlCblUzd293ZkNCQ2p2Vmh2aW9WeGZZeHdoV1llQWtF?=
 =?iso-2022-jp?B?VGVBTTVTQnlzNWNYNENXVmVmTGdnVnYwWE1CUnVvclc4aEE1WFlTM2ti?=
 =?iso-2022-jp?B?MVhWZUp1T05JandHWHBTNGRkeFcyT0MwNlRKTnJrM0hNNVZidEVMcXNx?=
 =?iso-2022-jp?B?VFUvOWh4cTZBMC9JeWNiWVZsQ0t4ZEpZeEdXRFl0L2ZmdFJ2UWk1VW5H?=
 =?iso-2022-jp?B?KythTjIwNGJ5Qkp4WVN4aTdiRjNSN2RtVlNtNGNkeDZaK01TWUJqUVZU?=
 =?iso-2022-jp?B?OTdUeklFWWJmZWhDL05wL05WbzNhMVZMb0QrUWl4Yk5PT2ZTalA5UTVH?=
 =?iso-2022-jp?B?SUJ5aFY0UGpXYVk5MnVXQW9lcHN6a1BRL0tyZHAzcXlBVzZjUVBPQXJm?=
 =?iso-2022-jp?B?WElEa3N0T3R4QjNsTGpyRHBzSitwcFFGRXgyME4yK0FKV1lDZlJobWto?=
 =?iso-2022-jp?B?U25tRUxUc0YwNUtBQTlYS0wzR0V1bmFtc0hobDVHYkZqOHl2N2FFM2tM?=
 =?iso-2022-jp?B?NjZIYzIzbWtFOUF2eVNZNDVjQVhxbVFmaDI4aFIwRUFENzY2MitsYTZX?=
 =?iso-2022-jp?B?SjA4YlBneXRqWE1zY0pHbC9WZm44QmgzZzljak84MlpaYW9xQlZKQjFD?=
 =?iso-2022-jp?B?S1FvYWVZSFl4SFZ0aUtrUXBaNkUrS2o2OTNGaDdEa3ZVSTNTUlJoNHNv?=
 =?iso-2022-jp?B?NjB1ZmpIaGFHVllCdzV5RlhlbEUyQkUwaXFlbEZtRjMvdTFFQmdvZytB?=
 =?iso-2022-jp?B?TGhlVVZ0eCtJa0h0KzdZdnI4Rjl5WkRCS3V0VHpyOUVwbE5uWStUQ295?=
 =?iso-2022-jp?B?TmhWa1dLR1hhNDZsS2FLMVQxckNwS0t3TEhobGkzbTVtdEVMUFBoMEZK?=
 =?iso-2022-jp?B?dHdDcENzdjBpcmR1dC9lcmVHMFdXN1FWZUVTb2x0aUNEYU5ldXh0ekI4?=
 =?iso-2022-jp?B?KzdzenE0YVJDVFRZdHY2ZXpsbGtQVCtLKzZkMFRsaTliUUdrQ3huU3pF?=
 =?iso-2022-jp?B?ZEc3dEc5ays4L1BuUCtoL1crcnA5Q2t4VWt1dDNrUmdtOC9LUVdVVTg1?=
 =?iso-2022-jp?B?OXh3RmRkeUxya1ZlSk1IUWpXb1VBYURIVlVvVnJSbTlKTmVRa1FuWlZh?=
 =?iso-2022-jp?B?ZXdNbkRKRXhVeGRjTjZhNFdmb0FEckJ6SHRZQjlUdWRNa1VyYzhXS2h6?=
 =?iso-2022-jp?B?OUZORVhzYng5bHdTMytOdTJRZi9sZjl6MHUvYmJSbFdGRmY1bXVYR0wy?=
 =?iso-2022-jp?B?WEFNNlB6azVPdWRkbkJabnFzYy9UTWVOajc2R2VVVlp0Vitnd3dEcnRK?=
 =?iso-2022-jp?B?aHVQTmxOb2dPcDgrcm1WWkUrOXhzL3hLaHM2UUlFNzFSb292Y05rSWpw?=
 =?iso-2022-jp?B?SmxFRDc1cFJaZnBnVmJnTEFvNXNCYnlJWklWNG9CRGk1L2dsL1p5bEsv?=
 =?iso-2022-jp?B?QlJXQzY3U2NUOWRqUGwzVDJuZUNFZUI3RXFoTUd3SVVDOUhSSUVEK1Vt?=
 =?iso-2022-jp?B?cjBRMlZqZnltQU9ZK2gwYUZ4R2VJZDVRdm9kOHNSY1daSUVnNDRlTHZn?=
 =?iso-2022-jp?B?dkhMUG1BPT0=?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB61031FB54CB5551D9013BE58C2FA2OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae61fab0-4a93-40a4-f1cd-08dc861e9390
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 11:48:26.2306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bS6NXJmrzJ5wzTgugvy4wj/lS0fSOC5TPGq5haTFNsIzDYBk2igYtqDgPa+EEtrVnqeCoyL6en5ua+S7jK6aOZ3MpV7J/pvplsEZUuE3Bg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB10955
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jun 2024 11:48:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16126

--_000_OS3PR01MB61031FB54CB5551D9013BE58C2FA2OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Package: syslog-ng-core
Version: 4.4.0-1
Severity: normal

Dear Maintainer,

When running with an initially empty /var partition, the syslog-ng.service
currently fails to start as the /var/lib/syslog-ng directory is not present=
.

syslog-ng.service status gives the below mentioned error message.
Error connecting control socket, socket=3D'/var/lib/syslog-ng/syslog-ng.ctl=
', error=3D'No such file or directory'

For details, please also see #945269

-- System Information:
Debian Release: 12.1
  APT prefers stable-updates
  APT policy: (500, 'stable-updates'), (500, 'stable-security'), (500, 'sta=
ble')
Architecture: amd64 (x86_64)

Kernel: Linux 6.1.0-9-amd64 (SMP w/8 CPU threads; PREEMPT)
Locale: LANG=3Den_IN, LC_CTYPE=3Den_IN (charmap=3DUTF-8), LANGUAGE=3Den_IN:=
en
Shell: /bin/sh linked to /usr/bin/dash
Init: systemd (via /run/systemd/system)
LSM: AppArmor: enabled

Versions of packages syslog-ng-core depends on:
ii  libc6                      2.36-9+deb12u1
ii  libcap2                    1:2.66-4
ii  libglib2.0-0               2.74.6-2
pn  libivykis0                 <none>
ii  libjson-c5                 0.16-2
ii  libnet1                    1.1.6+dfsg-3.2
ii  libpcre3                   2:8.39-15
ii  libssl3                    3.0.11-1~deb12u2
ii  libsystemd0                252.22-1~deb12u1

Thanks and regards,
Sai Ashrith Sathujoda

--_000_OS3PR01MB61031FB54CB5551D9013BE58C2FA2OS3PR01MB6103jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Package: syslog-ng-core<o:p></o:p></p>
<p class=3D"MsoNormal">Version: 4.4.0-1<o:p></o:p></p>
<p class=3D"MsoNormal">Severity: normal<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Dear Maintainer,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">When running with an initially empty /var partition,=
 the syslog-ng.service<o:p></o:p></p>
<p class=3D"MsoNormal">currently fails to start as the /var/lib/syslog-ng d=
irectory is not present.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">syslog-ng.service status gives the below mentioned e=
rror message.<o:p></o:p></p>
<p class=3D"MsoNormal">Error connecting control socket, socket=3D'/var/lib/=
syslog-ng/syslog-ng.ctl', error=3D'No such file or directory'<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">For details, please also see #945269<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">-- System Information:<o:p></o:p></p>
<p class=3D"MsoNormal">Debian Release: 12.1<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; APT prefers stable-updates<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; APT policy: (500, 'stable-updates'), (500, 's=
table-security'), (500, 'stable')<o:p></o:p></p>
<p class=3D"MsoNormal">Architecture: amd64 (x86_64)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Kernel: Linux 6.1.0-9-amd64 (SMP w/8 CPU threads; PR=
EEMPT)<o:p></o:p></p>
<p class=3D"MsoNormal">Locale: LANG=3Den_IN, LC_CTYPE=3Den_IN (charmap=3DUT=
F-8), LANGUAGE=3Den_IN:en<o:p></o:p></p>
<p class=3D"MsoNormal">Shell: /bin/sh linked to /usr/bin/dash<o:p></o:p></p=
>
<p class=3D"MsoNormal">Init: systemd (via /run/systemd/system)<o:p></o:p></=
p>
<p class=3D"MsoNormal">LSM: AppArmor: enabled<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Versions of packages syslog-ng-core depends on:<o:p>=
</o:p></p>
<p class=3D"MsoNormal">ii&nbsp; libc6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; 2.36-9+deb12u1<o:p></o:p></p>
<p class=3D"MsoNormal">ii&nbsp; libcap2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 1:2.66-4<o:p></o:p></p>
<p class=3D"MsoNormal">ii&nbsp; libglib2.0-0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.74.6-2<o:p></o:p></=
p>
<p class=3D"MsoNormal">pn&nbsp; libivykis0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;none&gt=
;<o:p></o:p></p>
<p class=3D"MsoNormal">ii&nbsp; libjson-c5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0.16-2<o:p>=
</o:p></p>
<p class=3D"MsoNormal">ii&nbsp; libnet1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 1.1.6+dfsg-3.2<o:p></o:p></p>
<p class=3D"MsoNormal">ii&nbsp; libpcre3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2=
:8.39-15<o:p></o:p></p>
<p class=3D"MsoNormal">ii&nbsp; libssl3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 3.0.11-1~deb12u2<o:p></o:p></p>
<p class=3D"MsoNormal">ii&nbsp; libsystemd0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 252.22-1~deb12u1=
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith Sathujoda<o:p></o:p></p>
</div>
</body>
</html>

--_000_OS3PR01MB61031FB54CB5551D9013BE58C2FA2OS3PR01MB6103jpnp_--


