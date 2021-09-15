Return-Path: <SRS0=wxp/=OF=lists.cip-project.org=bounce+64572+6737+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC29C433F5
	for <cip-dev@archiver.kernel.org>; Wed, 15 Sep 2021 14:41:00 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA5DD61209
	for <cip-dev@archiver.kernel.org>; Wed, 15 Sep 2021 14:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DA5DD61209
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ohp.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id rMFuYY4521723xaP99tK3PWv; Wed, 15 Sep 2021 07:40:59 -0700
X-Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by mx.groups.io with SMTP id smtpd.web11.8624.1631716857956735511
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Sep 2021 07:40:58 -0700
X-Received: from [10.0.1.210] ([45.14.189.13]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MXXhv-1mPGbw42Ix-00Z0h9 for <cip-dev@lists.cip-project.org>; Wed, 15 Sep
 2021 16:40:56 +0200
Message-ID: <860342fc-7cd4-f8d1-12e7-3fd7ec54a212@ohp.de>
Date: Wed, 15 Sep 2021 16:40:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [cip-dev] Watchdog triggered do_futex() on 4.4.277-cip60-rt35 #cip
From: "Sebastian Holzgreve" <holzgreve@ohp.de>
To: cip-dev@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
References: <9DmP.1631708090889080063.OWxj@lists.cip-project.org>
In-Reply-To: <9DmP.1631708090889080063.OWxj@lists.cip-project.org>
X-Provags-ID: V03:K1:oIknCswDzJhsqKFNzkn8iLxIjve8WOJ1nVDlxzX1HiQI5XZ0SCq
 eh/1ECBp/IUJEQFpvyB5PEM9fDm9+oUQanZSjivr2qjycm66oo28QXDEXhiLnhci/drQJmk
 StMTDo70yIhwxOB+AXch++GzqiBIhg6y4Io6TqHYLfQPQM1hbJAQSQ2gGSGFyRn3FfDF9cB
 shnQM37STKMn445GzC04w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f8fQ0iS5O/M=:r6JlT5pQnH9eXRpRN0I2vX
 enkP2Zh5CJUNVWVGxl6KEt6JmTn4/GQ+WU951q6KgAnNDtaffAR4DDsFTgb4bT2JcgA+/R7F3
 IVJeSJTr5ZQb7XFsvsKbv2jpVPTZLJ71WWZITOQu5gl9/OjcL9BUQ32ntaYI4B5FiLsUNG1TT
 yR2FuHyugfzR/qfWg4F8/QQw2qB59+hwfOqXG+2ywJCo7nGS3WkiOJL+DeHYOca869FRy0Fpf
 rfrKHXfkE3IXAyzqRzAodJTUjOBOxS/BB4rL5byf/WMiCknxwseXzzDf1r9mGtlzJ47AkG9oJ
 jvc7ucICto5X+kJbTYMcBZnt9bCVl7gUPg8HK0o+S0oOtlZ/PQX8izf6CtO6GxpC8SwvCXT/F
 ygo8A2U7s2sJhQ+mILUc9zOcrgcbn5/BdZ/W5wQ8iIWIgSKoS4Le8tOMw6ejL0qbZTNSxWGxR
 XptZB/xzA82fxFenyk36r2IsotqH2yKb0pA0kNwdcoAOd+VIK+lnQaO49KDdN8V+skmwHqxGz
 bo9eBXY8X1RwwGlyftRduXb+nz+gWOsymcuAKIK1VIfCmnjVc9WQSrRU8EBJqTj8u7fIxS+FC
 hJef2kBhG8f3mAWK2QxaEPu+k0NivBakquhFZ2q0nSzJeP9IHgdeF2ktB7DjGYAjhPs35tGge
 vrTDeKUntP4365A/dBZYi+fsPhUOmQLNuAis05icmds19vCxkhus730JnPtp+7cgpo3ldIBvc
 V39x3xSU1yQPDsIYLnYIBuZdX5uwaUizWWAVqg==
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
X-Gm-Message-State: W5Edy5ltqq7748psHeKUODAVx4520388AA=
Content-Type: multipart/mixed; boundary="NZl7yKpnRrACiHU7Z7eO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1631716859;
 bh=IZVaMECuIfZKYt07L8iBMIB7BoW2MbdBXSLBrZ8dA20=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=w+l8e75NZ2E9XBtDRdzO6odj1zc7UxCa1Oti30G0MO2NyZp0ASgrF1rLPfeAfjqWOMQ
 qLakaLTV+/TACxxawDuStMfkXMJP21y5MuDgcqqeihlWBjQI84lCSjlYCxIRihaGYnHRS
 H9LDFkFQ3eTfUaZHscW44PAexvQoC3EoQgk=

--NZl7yKpnRrACiHU7Z7eO
Content-Language: en-US
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms040002040109040900070707"

--------------ms040002040109040900070707
Content-Type: multipart/alternative;
 boundary="------------IOUt4sS03BoMeMPjwe09sjr9"

--------------IOUt4sS03BoMeMPjwe09sjr9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

> Hi,
>
> we were using the 4.4.277-cip60-rt35 kernel and it happens from time 
> to time that the kernel watchdog is triggered and our embedded devices 
> gets resetted.
>
> This message specially appers when we run the CodeSYS Runtime (PLC 
> runtime)
>
>     [  536.133081] NMI watchdog: BUG: soft lockup - CPU#0 stuck for
>     23s! [BlkDrvUdp:330]
>     [  536.140637] Modules linked in:
>     [  536.143756] CPU: 0 PID: 330 Comm: BlkDrvUdp Not tainted
>     4.4.277-cip60-rt35-ohp+gd23c00f1c39e #1
>     [  536.152489] Hardware name: Freescale Vybrid VF5xx/VF6xx (Device
>     Tree)
>     [  536.158967] task: 86bd7700 ti: 841aa000 task.ti: 841aa000
>     [  536.164408] PC is at do_futex+0x458/0xa98
>     [  536.168450] LR is at do_futex+0x428/0xa98
>     [  536.172487] pc : [<80069a40>]    lr : [<80069a10>]    psr: a0070013
>     [  536.172487] sp : 841abe90 ip : 86896244  fp : 841abf4c
>
>
> I contacted the support and they told me following about usage of 
> mutexes of the runtime:
>
> The runtime is using pi mutexes
>
>     pthread_mutexattr_setprotocol(&attr, PTHREAD_PRIO_INHERIT);
>
> and also with recursive attribute.
>
>     pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_RECURSIVE_NP);
>
> and that they got other customers that had also problems with this 
> constellation.
>
>
> My current knowledge of the linux kernel is not big enough to solve 
> that problem by myself. But i'm willed to learn more about the kernel 
> and maybe solve the problem by own.
>
>
> Can anyone give me a hint how to continue investigation of that problem?
> Maybe someone has solved that problem for another target hardware?
>
> Every RTFM hint is also welcome, when it least tell me the manual to 
> dig trough :)
>
> Kind regards,
> Sebastian


I tried the latest 4.19.206-cip57-rt22-kernel. In this kernel version 
the problem reported above doesn't occur.

For now we will use the 4.19 kernel.


Kind regards,

Sebastian

--------------IOUt4sS03BoMeMPjwe09sjr9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <blockquote type="cite"
      cite="mid:9DmP.1631708090889080063.OWxj@lists.cip-project.org">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      Hi,<br>
      <br>
      we were using the 4.4.277-cip60-rt35 kernel and it happens from
      time to time that the kernel watchdog is triggered and our
      embedded devices gets resetted.<br>
      <br>
      This message specially appers when we run the CodeSYS Runtime (PLC
      runtime)<br>
      <br>
      <blockquote>
        <div style="line-height: 1.42857;">[  536.133081] NMI watchdog:
          BUG: soft lockup - CPU#0 stuck for 23s! [BlkDrvUdp:330]</div>
        <div style="line-height: 1.42857;">[  536.140637] Modules linked
          in:</div>
        <div style="line-height: 1.42857;">[  536.143756] CPU: 0 PID:
          330 Comm: BlkDrvUdp Not tainted
          4.4.277-cip60-rt35-ohp+gd23c00f1c39e #1</div>
        <div style="line-height: 1.42857;">[  536.152489] Hardware name:
          Freescale Vybrid VF5xx/VF6xx (Device Tree)</div>
        <div style="line-height: 1.42857;">[  536.158967] task: 86bd7700
          ti: 841aa000 task.ti: 841aa000</div>
        <div style="line-height: 1.42857;">[  536.164408] PC is at
          do_futex+0x458/0xa98</div>
        <div style="line-height: 1.42857;">[  536.168450] LR is at
          do_futex+0x428/0xa98</div>
        <div style="line-height: 1.42857;">[  536.172487] pc :
          [&lt;80069a40&gt;]    lr : [&lt;80069a10&gt;]    psr: a0070013</div>
        <div style="line-height: 1.42857;">[  536.172487] sp : 841abe90 
          ip : 86896244  fp : 841abf4c</div>
      </blockquote>
      <br>
      I contacted the support and they told me following about usage of
      mutexes of the runtime:<br>
      <br>
      The runtime is using pi mutexes
      <blockquote>pthread_mutexattr_setprotocol(&amp;attr,
        PTHREAD_PRIO_INHERIT);</blockquote>
      and also with recursive attribute.<br>
      <blockquote>pthread_mutexattr_settype(&amp;attr,
        PTHREAD_MUTEX_RECURSIVE_NP);</blockquote>
      and that they got other customers that had also problems with this
      constellation.<br>
      <br>
      <br>
      My current knowledge of the linux kernel is not big enough to
      solve that problem by myself. But i'm willed to learn more about
      the kernel and maybe solve the problem by own.<br>
      <br>
      <br>
      Can anyone give me a hint how to continue investigation of that
      problem?<br>
      Maybe someone has solved that problem for another target hardware?<br>
      <br>
      Every RTFM hint is also welcome, when it least tell me the manual
      to dig trough :)<br>
      <br>
      Kind regards,<br>
      Sebastian<br>
    </blockquote>
    <p><br>
    </p>
    <p>I tried the latest 4.19.206-cip57-rt22-kernel. In this kernel
      version the problem reported above doesn't occur.</p>
    <p>For now we will use the 4.19 kernel.</p>
    <p><br>
    </p>
    <p>Kind regards,</p>
    <p>Sebastian<br>
    </p>
  </body>
</html>

--------------IOUt4sS03BoMeMPjwe09sjr9--

--------------ms040002040109040900070707
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DC0wggT0MIID3KADAgECAgMP4PYwDQYJKoZIhvcNAQELBQAwRTELMAkGA1UEBhMCREUxFTAT
BgNVBAoMDEQtVHJ1c3QgR21iSDEfMB0GA1UEAwwWRC1UUlVTVCBSb290IENBIDMgMjAxMzAe
Fw0xMzA5MjcwNzMwNDBaFw0yODA5MjAwODI1NTFaMFsxCzAJBgNVBAYTAkRFMRUwEwYDVQQK
DAxELVRydXN0IEdtYkgxNTAzBgNVBAMMLEQtVFJVU1QgQXBwbGljYXRpb24gQ2VydGlmaWNh
dGVzIENBIDMtMSAyMDEzMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsL/U1GFo
1h3boKtaIzrEMPZHGI4FKLKLkjWJZYh1CSa4URX8j52diNu1tmcTpwKOMiv03awa2lEElvrq
VEhpMHOxK42q7WG7c4d0lkc7d+cTrexeZlGAZ8rIsXcASttIf0106PkzjHclKZrJ6iN11ToW
kjpPBsE9THKJ/2awtRHDVQTq5Ode7n1aGay3/nNIeMf1ALe4Q93Xx2glcXU0ZgLPftRQKJF5
ql800EgWWPe+tHArNBWzPh+NhoMzKfghnR+kPyUiFHd+ZzU+FU1XAvrqw3UAzPhp4vTKVXS+
IgqE9bRZW5CzBnXyZPFFtbuA3UJHPwKnS0bHNrw6DxIjrwIDAQABo4IB1TCCAdEwHwYDVR0j
BBgwFoAUP5DIfccVb/Mkj6nDL0uiDyGyL+cwQgYIKwYBBQUHAQEENjA0MDIGCCsGAQUFBzAB
hiZodHRwOi8vcm9vdC1jYS0zLTIwMTMub2NzcC5kLXRydXN0Lm5ldDBmBgNVHSAEXzBdMFsG
CysGAQQBpTQCgUgBMEwwSgYIKwYBBQUHAgEWPmh0dHA6Ly93d3cuZC10cnVzdC5uZXQvaW50
ZXJuZXQvZmlsZXMvRC1UUlVTVF9Sb290X1BLSV9DUFMucGRmMIG+BgNVHR8EgbYwgbMwdKBy
oHCGbmxkYXA6Ly9kaXJlY3RvcnkuZC10cnVzdC5uZXQvQ049RC1UUlVTVCUyMFJvb3QlMjBD
QSUyMDMlMjAyMDEzLE89RC1UcnVzdCUyMEdtYkgsQz1ERT9jZXJ0aWZpY2F0ZXJldm9jYXRp
b25saXN0MDugOaA3hjVodHRwOi8vY3JsLmQtdHJ1c3QubmV0L2NybC9kLXRydXN0X3Jvb3Rf
Y2FfM18yMDEzLmNybDAdBgNVHQ4EFgQUGQOq2SJFxxpiqedcmbCd3u3UuLUwDgYDVR0PAQH/
BAQDAgEGMBIGA1UdEwEB/wQIMAYBAf8CAQAwDQYJKoZIhvcNAQELBQADggEBABCOUPipaQNk
TuhlpNOQk8lDCndO0Y9nuN8+Y99m/odfdUDN2MmOg0ICPVWNyg9bIHfxytRkNlFzCrc7B9Km
zPAAiu7UwOXl3dnRrFJpluGcAbnDGRr1Ssgvb2HDmZwlU2K7TpMOt6XayFkiefx5q4WC67Bb
VcIPD1IZ2te0HRdmdh7zhIz2Hw1+bfuzzSNf8/JRYojIyweGq9uDue45yhVDl86O3GJaOphj
DVm5c7mTdWg1xbJ244PhmpQH3h1s+kfD76rg4mwAIQa3QkfX2BqMEc9ASiWm1L9iNA0Z4ng9
tiuVm4LJKPVA2lZppx7+KtmVmv0/lv+8eGKwPvw1HlUwggcxMIIGGaADAgECAhBPyMh5nYrC
y2uIfpDzTuWdMA0GCSqGSIb3DQEBCwUAMFsxCzAJBgNVBAYTAkRFMRUwEwYDVQQKDAxELVRy
dXN0IEdtYkgxNTAzBgNVBAMMLEQtVFJVU1QgQXBwbGljYXRpb24gQ2VydGlmaWNhdGVzIENB
IDMtMSAyMDEzMB4XDTIxMDUxMTA3MzMwN1oXDTIzMDUxNTA3MzMwN1owgbIxCzAJBgNVBAYT
AkRFMSQwIgYDVQQKExtPSFAgQXV0b21hdGlvbiBTeXN0ZW1zIEdtYkgxHDAaBgNVBAMTE1Nl
YmFzdGlhbiBIb2x6Z3JldmUxDzANBgNVBAcTBlJvZGdhdTESMBAGA1UEKhMJU2ViYXN0aWFu
MRIwEAYDVQQEEwlIb2x6Z3JldmUxFTATBgNVBAUTDENTTTAyNjE4MzMxMjEPMA0GA1UECBMG
SGVzc2VuMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA5I/hMM9AxL9ul5PX34JF
WhOmZITMmbDSapfDM3GYI0LOsLNLmWxCZ3hIc4Rv/1JfMNNpcEOui3ncGI5CSskWSbZry/kE
NNs4bykp7MGFyVbIRJxDDfFNRVqWUoNVHY0zeHt43pvngeijrvTvxS8wDm+VWfSdpBO3gK0t
3vqpFDgX5PUvowtxal9SyJzCsxt9i1+jsE8D3LCUI6eKRZQ5mQ0jzzYGgDSBoyPbn9p+JlX5
6laWJ6AQIP1WgZgs4+Ac7F8bf8hYCZz39SU9IrT6eFLnu00R6qKOW0wPsL2doU7z/eRrgn7Z
7IN75E1Z/0Js7BiAO133q2M5XFtQgm3t4QIDAQABo4IDlzCCA5MwHQYDVR0lBBYwFAYIKwYB
BQUHAwIGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFBkDqtkiRccaYqnnXJmwnd7t1Li1MIIBSQYI
KwYBBQUHAQEEggE7MIIBNzBIBggrBgEFBQcwAYY8aHR0cDovL2FwcGxpY2F0aW9uLWNlcnRp
ZmljYXRlcy1jYS0zLTEtMjAxMy5vY3NwLmQtdHJ1c3QubmV0MFsGCCsGAQUFBzAChk9odHRw
Oi8vd3d3LmQtdHJ1c3QubmV0L2NnaS1iaW4vRC1UUlVTVF9BcHBsaWNhdGlvbl9DZXJ0aWZp
Y2F0ZXNfQ0FfMy0xXzIwMTMuY3J0MIGNBggrBgEFBQcwAoaBgGxkYXA6Ly9kaXJlY3Rvcnku
ZC10cnVzdC5uZXQvQ049RC1UUlVTVCUyMEFwcGxpY2F0aW9uJTIwQ2VydGlmaWNhdGVzJTIw
Q0ElMjAzLTElMjAyMDEzLE89RC1UcnVzdCUyMEdtYkgsQz1ERT9jQUNlcnRpZmljYXRlP2Jh
c2U/MG8GA1UdIARoMGYwWgYLKwYBBAGlNAKBSAIwSzBJBggrBgEFBQcCARY9aHR0cDovL3d3
dy5kLXRydXN0Lm5ldC9pbnRlcm5ldC9maWxlcy9ELVRSVVNUX0NTTV9QS0lfQ1BTLnBkZjAI
BgYEAI96AQMwggFFBgNVHR8EggE8MIIBODCCATSgggEwoIIBLIaBhmxkYXA6Ly9kaXJlY3Rv
cnkuZC10cnVzdC5uZXQvQ049RC1UUlVTVCUyMEFwcGxpY2F0aW9uJTIwQ2VydGlmaWNhdGVz
JTIwQ0ElMjAzLTElMjAyMDEzLE89RC1UcnVzdCUyMEdtYkgsQz1ERT9jZXJ0aWZpY2F0ZXJl
dm9jYXRpb25saXN0hktodHRwOi8vY3JsLmQtdHJ1c3QubmV0L2NybC9kLXRydXN0X2FwcGxp
Y2F0aW9uX2NlcnRpZmljYXRlc19jYV8zLTFfMjAxMy5jcmyGVGh0dHA6Ly9jZG4uZC10cnVz
dC1jbG91ZGNybC5uZXQvY3JsL2QtdHJ1c3RfYXBwbGljYXRpb25fY2VydGlmaWNhdGVzX2Nh
XzMtMV8yMDEzLmNybDAdBgNVHQ4EFgQUdQabPJQq4JCBCDRUQNALNPCPyLYwDgYDVR0PAQH/
BAQDAgSwMBsGA1UdEQQUMBKBEGhvbHpncmV2ZUBvaHAuZGUwDQYJKoZIhvcNAQELBQADggEB
AKd+IGuyxLSOFLgo9/EFnRE7wYtyZL/5IJYqBYVxy/KPJqF1KOCNFuoe6RzegKjcqtazztVJ
kz9ThHsP3IRnR6gjB+QelndGf/2vjWtHkgJxKEIkAUovUn2n3t2DM5fSb/3kWwb/5ErdTpUX
NsAZKQm9MNqeysVVA/61gpFgiUWPkvmBSlnHEWE5QKjQ8t15ppCalHL6ZrLuJisHQQUS+xnh
ayNXQbFsfCkas1fwngCsvkfStZgZNxM7mzx4zbQKG9cGKSXz8AItUfeMQu8svkP8rZQhJ1Bk
PKWR6rIEKSWLOslfguIL/iy6sF5m7PFw+VsTOnr9Ut5lR1i29rGpLwQxggN4MIIDdAIBATBv
MFsxCzAJBgNVBAYTAkRFMRUwEwYDVQQKDAxELVRydXN0IEdtYkgxNTAzBgNVBAMMLEQtVFJV
U1QgQXBwbGljYXRpb24gQ2VydGlmaWNhdGVzIENBIDMtMSAyMDEzAhBPyMh5nYrCy2uIfpDz
TuWdMA0GCWCGSAFlAwQCAQUAoIIB2jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0yMTA5MTUxNDQwNTVaMC8GCSqGSIb3DQEJBDEiBCDBJbXHuavXkgUPAzv8
Aca0vSlg+VIUiYRpY5EmpkPgazBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMH4GCSsGAQQBgjcQBDFxMG8wWzELMAkGA1UEBhMCREUx
FTATBgNVBAoMDEQtVHJ1c3QgR21iSDE1MDMGA1UEAwwsRC1UUlVTVCBBcHBsaWNhdGlvbiBD
ZXJ0aWZpY2F0ZXMgQ0EgMy0xIDIwMTMCEE/IyHmdisLLa4h+kPNO5Z0wgYAGCyqGSIb3DQEJ
EAILMXGgbzBbMQswCQYDVQQGEwJERTEVMBMGA1UECgwMRC1UcnVzdCBHbWJIMTUwMwYDVQQD
DCxELVRSVVNUIEFwcGxpY2F0aW9uIENlcnRpZmljYXRlcyBDQSAzLTEgMjAxMwIQT8jIeZ2K
wstriH6Q807lnTANBgkqhkiG9w0BAQEFAASCAQA829n9hcf8Hs9j+EQHK5Pbts8fu67SCtQz
HTTqj/HNjiIL2zkKXM2WTS7mDNKy5yJ6Fl9vpQd8l/0EJUlQbbeBA0dxwUPvf2Pus+U3sCMD
+2Sj7bOHRkmgx8ohgeCRP9YM3LiPqNLYq8u99OG0eYqyBT6cH1fnpiDn2uG5pSlmj752x7SK
w/Q70m4fGhlzr1z5Kwti4Uf01gqsLz2guRJ9BOxCTY5Ams7OCJs16/orYGqBSsiG67O5TPhb
2wLqcxA6vCY5ORkPqq050AICoeH6NnpJFseL4JimS4/er9t8vxsGgbtoGOaawISUVImoQcRR
fa+bfGuNwE7K3CiGkD+yAAAAAAAA

--------------ms040002040109040900070707--

--NZl7yKpnRrACiHU7Z7eO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6737): https://lists.cip-project.org/g/cip-dev/message/=
6737
Mute This Topic: https://lists.cip-project.org/mt/85625711/4520388
Mute #cip:https://lists.cip-project.org/g/cip-dev/mutehashtag/cip
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--NZl7yKpnRrACiHU7Z7eO--
