require "should_send_same_site_none/version"

module ShouldSendSameSiteNone
  class Error < StandardError; end
  def is_same_site_compatible(user_agent)
    return has_webkit_bug(user_agent) || drops_unrecognized_same_site(user_agent)
  end

  private

  def has_webkit_bug(user_agent)
    return is_ios_version(12, user_agent) || (
      is_macosx_version(10, 14, user_agent) &&
      (is_safari(user_agent) || is_mac_embedded_browser(user_agent))
    )
  end

  def drops_unrecognized_same_site(user_agent)
    return (is_chromium_based(user_agent) &&
    is_chromium_version_at_least(51, user_agent) &&
    !is_chromium_version_at_least(67, user_agent)) ||
    (is_uc_browser(user_agent) && !is_uc_browser_version_at_least(12, 13, 2, user_agent))
  end

  def is_ios_version(major, user_agent)
    regex = /\(iP.+; CPU .*OS (\d+)[_\d]*.*\) AppleWebKit\//
    # Extract digits from first capturing group.
    extract_regex_match(user_agent, regex, 1) == major.to_s
  end

  def is_macosx_version(major, minor, user_agent)
    regex = /\(Macintosh;.*Mac OS X (\d+)_(\d+)[_\d]*.*\) AppleWebKit\//
    extract_regex_match(user_agent, regex, 1) == major.to_s && extract_regex_match(user_agent, regex, 2) == minor.to_s
  end

  def is_safari(user_agent)
    safari_regex = /Version\/.* Safari\//
    user_agent.match(safari_regex) != nil && !is_chromium_based(user_agent)
  end

  def is_mac_embedded_browser(user_agent)
    regex = /^Mozilla\/[\.\d]+ \(Macintosh;.*Mac OS X [_\d]+\) AppleWebKit\/[\.\d]+ \(KHTML, like Gecko\)$/
    regex_contains(user_agent, regex)
  end

  def is_chromium_based(user_agent)
    regex = /Chrom(e|ium)/
    regex_contains(user_agent, regex)
  end

  def is_chromium_version_at_least(major, user_agent)
    regex = /Chrom[^ \/]+\/(\d+)[\.\d]* /
    version = extract_regex_match(user_agent, regex, 1).to_i
    return version >= major
  end

  def is_uc_browser(user_agent)
    regex = /UCBrowser\//
    regex_contains(user_agent, regex)
  end

  def is_uc_browser_version_at_least(major, minor, build, user_agent)
    regex = /UCBrowser\/(\d+)\.(\d+)\.(\d+)[\.\d]* /
    major_version = extract_regex_match(user_agent, regex, 1).to_i
    minor_version = extract_regex_match(user_agent, regex, 2).to_i
    build_version = extract_regex_match(user_agent, regex, 3).to_i
    if (major_version == major)
      return major_version > major
    end

    if (minor_version != minor)
      return minor_version > minor
    end

    return build_version >= build
  end

  def extract_regex_match(string_value, regex, offsetIndex)
    matches = stringValue.match(regex)

    if (matches != nil && matches[offsetIndex] != nil)
      return matches[offsetIndex]
    end

    return nil
  end

  def regex_contains(string_value, regex)
    string_value.match(regex)
    return matches != nil
  end
end
