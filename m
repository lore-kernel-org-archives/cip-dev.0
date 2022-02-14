Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82473C433EF
	for <webhook@archiver.kernel.org>; Mon, 14 Feb 2022 07:35:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web11.30910.1644824145869695069
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Feb 2022 23:35:47 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.157, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 21E7ZPZ0022592;
 Mon, 14 Feb 2022 16:35:25 +0900
X-Iguazu-Qid: 2wGqpEkoE9HZNEJ6wx
X-Iguazu-QSIG: v=2; s=0; t=1644824124; q=2wGqpEkoE9HZNEJ6wx;
 m=EhIDyzvR9C+iD3SIxVUAptdOqRQsXYq13eacfuRMFpI=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1110) id 21E7ZLid017626
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 14 Feb 2022 16:35:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmUJcN9w2MM6mHh6S/8GRymEyXthBbNjBJGo/+2tjyDH8oG/cDngJvs+WpCp2Tfjk8swD9RQP43WI6eDZbl6IqW+3ABC+ogDgNbdQKXIRXgsgqNVXilrNgrpCYdO/kQ3/gMO8IQ9wiVxy4nP3Mac6asZKIaF5q3Cg64I+pjYSbGDmCnCsIcbJJKHmxwyoZtLrT4nUGgPb6v2LtYAuWxoc5Zyl7lAjEWFkZ47eXU9lsF+RyQNqUCEUf7CQTi3qfvzM4JYcsRm+ZV8LfjC3zsHTS6G0Hz9Zowue8SXskzBq6d035+rVrODzeMF6Jand+GtpnloYXfy035mIgZlPZdf1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7FQ4FCCtKECEEOjePu9B7HWs16eM5DjD2lIDKqrXFk=;
 b=HDTa5vW80NtPfZOhyiHKTKqtCrivQRPE57pn2/mslKJPXPt/4OHopvMwdmgYYNx0LomYICsmqD0BWQeHJy3INbuQCNMLc30UBcLquz2mpA4cLbfZ/h/qYURrVhV7VetTiD/1YdfFVbGWCAgWt9CUkE3YAV7CbdaQk146JE6pgUyc44CKpzEUkqCRpAgjPh0bSmwTFX0SDA04VeiN4IXva63BMEw0dfSt196UT3LTxmhPVZdbJzl63i7SZ5lf9+PVQVdLB1nQrpWe7mBW9l/++vRsZH0YypT9KHJWoYMc8eOUtMgpBBFaVhvln63rDuK7Bqz6DjKR/leXcz/CJFnc5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v4.19.226-cip66 and v4.4.302-cip68
Thread-Topic: [ANNOUNCE] Release v4.19.226-cip66 and v4.4.302-cip68
Thread-Index: AdghdVZOJAEUrhB6SZCwAgGYA5UwCg==
Date: Mon, 14 Feb 2022 07:35:19 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYAPR01MB625274EA966C12C93F817E8C92339@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce07e439-253f-49de-df0b-08d9ef8c8d2a
x-ms-traffictypediagnostic: TYCPR01MB9862:EE_
x-microsoft-antispam-prvs: 
 <TYCPR01MB9862E13F6F30B5E8BB915A1192339@TYCPR01MB9862.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 F8oHSjT6ZXHK7wxQwEKsDZBna38YzM2nT4RXeDr99OdaOBSfAHEpYHkuw6fM0opLMGhqBVOfhDvj6h0WNjRHfoK2MWwlyrHULACgymqxjUlmEhQVP9janSiZ3lCqgvQoS39+T3NA0MLQU86NY9YfmehDyj9vyzoo6S9/9MndVxz0GL4Hgv6peP8z5p11D+gG75H3BW2lHHq9zAwjKO+y0uekIh88QPCrya4QPzP6iMnqOP76xM2Y5w4T/q9FziH1t4cRkfEnB81zk3KGV5mRk+ZJ5hkv6MRva48R/6CG/4NT1FAEzYLgGMlF9Vsu640GXJUabZt20L2Vow4Mre6O6j+FmcM5CP7dJ3BU/NnWkucULd8MCwKUvME1eLxEI2ADW7g883wDeVn8iCq9kGmFCG3L8carVa0CRIga/v4OVyXHxOSKBEG5qgEpkuMXEbpX+16H33mE/MxW4RXlMzyASl8P2q7aoNfDuSKiBo68Lemf1mCPPT17Uhyax0Builk7um1k6og6GyweUMbXrowVnWfQ5r6ZH39x1NghNAIV+L8YqAwHHxVEXdA3efnD4Poln6AN6fAkvFTg/4rltdUID1gwesViQ43xifsMO4zu9+r52MyAhv7p6AJcxhQo7Uc2MIBzwI7wP2KjViouVf8SUHYjEk03KybEc6feWOZ1TXZdecu3+/qohgLat5Fy0IhTSn+wPXclObHiqhq1u4WL03/yzuC3Gnswat3ko/xJ68GkQZhOi/Qu8VZzXBANmlHUHoElk2yxZ3t/jrVXQdC//gVXjK/A+evw+zqVzJs8P82X6s3AHhzj52Qx8FWoFSd4NXM3ZkhYOTHCS+hDXt9Zwg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(52536014)(6916009)(71200400001)(83380400001)(38100700002)(2906002)(54906003)(508600001)(122000001)(966005)(86362001)(76116006)(33656002)(186003)(26005)(9686003)(4326008)(8936002)(7696005)(8676002)(6506007)(66446008)(66476007)(66556008)(66946007)(5660300002)(55016003)(38070700005)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SERDdWdudVdHcDB4L01CSFlGdTZ0V2R2NHFCek5seGwvWWlsOXoybWFR?=
 =?iso-2022-jp?B?THk5eWVLTHFadW4zZkNDZ3ppTVprUXNVU0tKV3dmZHdselN0S0RySjhx?=
 =?iso-2022-jp?B?SjFIUUNNVTBXbFdMdHAvTXNSUExhOWNWSDlHQjBUWkQ4ck9CZGpjNW5P?=
 =?iso-2022-jp?B?UkEzOURZQTVnaWxLR0pzWTk2T3VqRThlOG92NW9MUHAya2RMUGNVMDlq?=
 =?iso-2022-jp?B?S1o4bTZWU243bUxhQWFicmVOUXQvTzlybDUzOXA0b3dNeHlpOVdLUDBU?=
 =?iso-2022-jp?B?UGFqWDJIRzI4SzB3cTRhYytzL1NCY1NjNjB5Zk5kczgrWGZSVFBZb1F1?=
 =?iso-2022-jp?B?QmN1WDZXQ3pScEFuNHYwczBDc01IYlVDZ1JqMWhaTnd1RGR0WFFaZFR4?=
 =?iso-2022-jp?B?VlFmTS9RVkNoaHVVVHY5YUlVd3p6M2hjV01ZVEpOTFk0bjFKU2gxS3lj?=
 =?iso-2022-jp?B?K0pibFdva3hzY2NsRUtZZ1JCWVdnTW1RNHBIR1dnWHppdlQ3Tjk3eE0r?=
 =?iso-2022-jp?B?MkZIN0xBZE9oUklXSXllbVNjYTZjcm81WkdTdm9wQnV3YWZ6b2EyS0xE?=
 =?iso-2022-jp?B?cytuRnl3SjhNS1dzdUhJNkpqdlhzRWVxZmk3dEV4MU1YK3dQTWhucTBq?=
 =?iso-2022-jp?B?UnlobjZFSUNWVU1QSFRUSVRzVjAvOTlrOFZQQ3dsaWNxVVgzYmh0VmpW?=
 =?iso-2022-jp?B?UExqdzVNdC9tM2JZTGdBZUZMTm1PTEtOeGZtL0w5RE5HaUNlaU5qVWZO?=
 =?iso-2022-jp?B?MEU2UEtPakR6VXpxZ0JmU0FSNWhQLzlJZXl3amdQcWtUUnZEOHRSSlho?=
 =?iso-2022-jp?B?czF5WmxRcG0vT2lEcEVQSVJEdGZEVHBpU09zMmZjMVYwQklRTkdNaVhE?=
 =?iso-2022-jp?B?RTV5blpiOWJ3VWk4MVpma3BLbVpDU1AxWGpxOGhDbGxITHM4czJ6azFz?=
 =?iso-2022-jp?B?cjM5S3ZJZ1lYU2I1cHl3WXc5VFpEd2VjaXZtZDNSRlNyQXBGcXhzc0Va?=
 =?iso-2022-jp?B?UnRmUStzcEZQeVo1UEtUSVUxRHV6dE5RTXhCYm5NeE9DQ2pUV3BDejVC?=
 =?iso-2022-jp?B?L0Y3SEk5ZVhZT3lIdHhiTHhqV2t1YXdJN3JNUDRwVWdEMjY2dE1MakVD?=
 =?iso-2022-jp?B?THc4MTRFWWhINmswaFB0V05zMmhONGlZUVU4QWM1L0VlOE1zdFVtSDZN?=
 =?iso-2022-jp?B?WVc5OW9xbzI2aFZoWkJBd3RUWEE0ajYzVlp2VDVGeGFHSXlCeEo1ZDlV?=
 =?iso-2022-jp?B?SnNnVHY3S3NObmxHK0M5TFV4WUtwTkdyU2xYR3FHcXl6K0xaVmRqc3Vm?=
 =?iso-2022-jp?B?OU5saWVIUjhwdDFIZ3djTTByK3NnNVVNVXFFaDY4NmRsTnZHWWdBMHZa?=
 =?iso-2022-jp?B?aXpSaTVjNkVONEtXYWFhOXF1RUVwV2dHKzhsTzdpUFJ0SnFybStyZUJQ?=
 =?iso-2022-jp?B?NnFIYUNlQVNNMmtveHZSZTR5Ym5KOERJNW9mb21XbklSb2dKUU4rS0I0?=
 =?iso-2022-jp?B?aDdNb1FLaHExUS83dlVNZTEvYTF6RzdEQTdsdlJQTzVFeklIRHR4V09n?=
 =?iso-2022-jp?B?REs5bW1aRkFxT3NzOWdOMG1BbjMvSGxOc2tNU3pDTGhxemVNTUYycWpW?=
 =?iso-2022-jp?B?aXdiYk9NTlFCc0tyR0ptT2lMLzRmK3AxMm5peEZWRURtTU9hUFNEMXlv?=
 =?iso-2022-jp?B?UzRVbTVkWC9CT0FNa0IrK3RVWEg2SGJmRUFPZ24yWGRaWDNUOFVHK0Ir?=
 =?iso-2022-jp?B?Y0h0L01OMTFjaHJib1cyN2wra0EveUxWaDEzYVFwM2NERW1wOXdkcWdR?=
 =?iso-2022-jp?B?THJxeGo1ZmYxRXVqZzhyajRZOUJRNVBRTHA5U3JLK2pZWnd3NS9IZTAr?=
 =?iso-2022-jp?B?aTh6WmRSNVh2NFNJVEY2SWJ5cUFtM2F6UGRnNUlHbFJBZVZwT0F6bmtt?=
 =?iso-2022-jp?B?SjF4bkxiREViRDFtTVBtSEEyeTBpQWVTZ0p0dEpzcE1XczkyYWF0YlJE?=
 =?iso-2022-jp?B?dGtGcXE3NXBJc0VXRkVsM2hGVytyVEQ0Q2oySkNnR041dEYzcFA0K3lv?=
 =?iso-2022-jp?B?L0hTZVZzckNOUVdLQXFNVlQ2WVJWS3RJd29MWGZwWjlIV2IzODArVU00?=
 =?iso-2022-jp?B?WGJqYzh5SlVIZzVVSmdNZG5NQS9rQ0oyOHNQSHhiTlRNYUt5a1N0Wldm?=
 =?iso-2022-jp?B?MjB5U3BpdEpzMzdMVjZwREtaUTZacG8vMGxEQ0tZZzloSVVtUk41VXEy?=
 =?iso-2022-jp?B?K3dmc3NlR0hTU2xMQXN6UnFvWjJhZUVzN2Jtd3JmWTRadHBuN1BSb1Qy?=
 =?iso-2022-jp?B?NkwvcUJYamJKL3FDRTRjWXo5VHIyYW9pRUlRTitFdzVDRUNwOHlzb1A5?=
 =?iso-2022-jp?B?elAwbDdIY2xDZXBFS0VkV1FmaE1rdkp6Nzlqc1hMSDY0QWYxd1ZicXpw?=
 =?iso-2022-jp?B?dy9kR0UwWE5hTWpCNmpKSFRYWjQxbUdNNk5hYTV4a0Z4WGdFRUJTVmZr?=
 =?iso-2022-jp?B?b2oxUldT?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ce07e439-253f-49de-df0b-08d9ef8c8d2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 07:35:19.1867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 vwrRM/OcyP910MCFXCAP5QbO5UboIyhhIaj02AMak35ai17iO2g6hqTaTtRxyQLcXxJqXRKEDM1vY8F2ID6CpkDIIxlR0VuoDltIDoW1NtCI5hE6kgER32kJo62lTQ4A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9862
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Feb 2022 07:35:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7590

Hi,

CIP kernel team has released Linux kernel v4.19.226-cip66 and v4.4.302-cip6=
8.
The linux-4.19.y-cip tree has been updated base version from v4.19.226 to v=
4.19.229, and The linux-4.4.y-cip tree has been updated base version from
v4.4.296 to v4.4.302.

The 4.4.y tree is EOL[0], and the release from the LTS ends.

You can get this release via the git tree at:
  v4.19.229-cip67:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      c390d35f51edb249e63aab6fb5086ac4e0bf90d4
    Fixed CVEs:
      - CVE-2022-0330: drm/i915: Flush TLBs before releasing backing store
      - CVE-2022-22942: drm/vmwgfx: Fix stale file descriptors on failed us=
ercopy
      - CVE-2022-24448: NFSv4: Handle case where the lookup of a directory =
fails
    added commits:
      CIP: Bump version suffix to -cip67 after merge from stable

  v4.4.302-cip68:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      ea2b25643aed790866a050f9605bbe7b845b8f31
    Fixed CVEs:
      - CVE-2021-45095: phonet: refcount leak in pep_sock_accep
      - CVE-2021-4155: xfs: map unwritten blocks in XFS_IOC_{ALLOC,FREE}SP =
just like fallocate
      - CVE-2021-43976: mwifiex: Fix skb_over_panic in mwifiex_usb_recv()
      - CVE-2022-0330: drm/i915: Flush TLBs before releasing backing store
    added commits:
      CIP: Bump version suffix to -cip68 after merge from stable

[0]: https://lore.kernel.org/stable/1643877137240249@kroah.com/

Best regards,
   Nobuhiro


