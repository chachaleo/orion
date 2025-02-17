use orion::operators::tensor::core::{Tensor, TensorTrait};
use orion::operators::tensor::math::{exp::exp_upcast, arithmetic::div_downcast};
use orion::numbers::fixed_point::core::FixedTrait;

/// Cf: NNTrait::softmax docstring
fn softmax<
    T,
    impl TTensor: TensorTrait<T>,
    impl TTensorDiv: Div<Tensor<T>>,
    impl TCopy: Copy<T>,
    impl TDrop: Drop<T>,
>(
    z: @Tensor<T>, axis: usize
) -> Tensor<T> {
    let exp_tensor = z.exp();
    let sum = exp_tensor.reduce_sum(axis, true);
    exp_tensor / sum
}

/// Cf: NNTrait::softmax docstring
fn softmaxWide<
    T,
    TMAG,
    W,
    WMAG,
    impl TTensor: TensorTrait<T>,
    impl WTensor: TensorTrait<W>,
    impl TDiv: Div<T>,
    impl TIntoW: Into<T, W>,
    impl WTryIntoT: TryInto<W, T>,
    impl TCopy: Copy<T>,
    impl TDrop: Drop<T>,
    impl WCopy: Copy<W>,
    impl WDrop: Drop<W>,
    impl TFixed: FixedTrait<T, TMAG>,
    impl WFixed: FixedTrait<W, WMAG>,
>(
    z: @Tensor<T>, axis: usize
) -> Tensor<T> {
    let exp_tensor: Tensor<W> = exp_upcast(*z);
    let sum = exp_tensor.reduce_sum(axis, true);
    div_downcast(@exp_tensor, @sum)
}

