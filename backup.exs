defmodule MyBinary do
  def capitalize_sentences(sentences, acc \\ <<>>)

  def capitalize_sentences(<<?., ?\s, tail::binary>>, acc) do
    String.capitalize(acc) <> capitalize_sentences(tail)
  end

  def capitalize_sentences(<<head::utf8, tail::binary>>, acc) do
    capitalize_sentences(tail, acc <> <<head>> )
  end

  def capitalize_sentences(<<>>, _) do
    <<>>
  end
end
